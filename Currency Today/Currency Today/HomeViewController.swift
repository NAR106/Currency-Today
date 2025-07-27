//
//  HomeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit



class CurseOption{
    var name: String
    var currency: String
    var backgroundImage: UIImage
    var backgroundColor: UIColor
    var course: String
    
    
    init(name: String, currency: String, backgroundImage: UIImage, backgroundColor: UIColor, course: String) {
        self.name = name
        self.currency = currency
        self.backgroundImage = backgroundImage
        self.backgroundColor = backgroundColor
        self.course = course
    }
}


class HomeViewController: UIViewController {

    @IBOutlet weak var Data: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    var models = [CurseOption]()
    var currencyCode: [String] = []
    var volues: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        getCurrentDate()
        configure()
        fetchJson()
    }
    func fetchJson(){

            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else {return}
            URLSession.shared.dataTask(with: url) {[self] (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let safeData = data else {return}
                    do{
                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                    self.currencyCode.append(contentsOf: rezults.rates.keys)
                    self.volues.append(contentsOf: rezults.rates.values)

                    rezults.rates.forEach { (key, value) in

                        self.models = self.models.map {

                            if $0.name == key {

                                let courseKey = (Double(models[0].course) ?? 0)/value

                                $0.course = "\(Double(round(100 * courseKey) / 100))"

                            }

                            return $0

                        }

                    }

                    DispatchQueue.main.async {

                        self.tableView.reloadData()

                    }

                }

                catch {

                    print(error)

                }

            }.resume()

        }
    func configure(){
        models.append(contentsOf: [
            CurseOption(name: "AMD", currency: "Armenia", backgroundImage: UIImage(named: "Flag_of_Armenia")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "USD", currency:"USA", backgroundImage: UIImage(named: "Flag_of_Unitade States")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "RUB", currency:"Russia", backgroundImage: UIImage(named: "Flag_of_Russia")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "CNY", currency:"China", backgroundImage: UIImage(named: "Flag_of_China")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "JPY", currency:"Japan", backgroundImage: UIImage(named: "Flag_of_Japan")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "ARS", currency:"Argentina", backgroundImage: UIImage(named: "Flag_of_Argentina")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "BGN", currency:"Bulgaria", backgroundImage: UIImage(named: "Flag_of_Bulgaria")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "CAD", currency:"Canada", backgroundImage: UIImage(named: "Flag_of_Canada")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "CHF", currency:"Switzerland", backgroundImage: UIImage(named: "Flag_of_Switzerland")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "BDT", currency:"Bangladesh", backgroundImage: UIImage(named: "Flag_of_Bangladesh")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "GEL", currency:"Georgia", backgroundImage: UIImage(named: "Flag_of_Georgia")!, backgroundColor: .systemGray4, course: "1"),
            CurseOption(name: "BYN", currency:"Belarus", backgroundImage: UIImage(named: "Flag_of_Belarus")!, backgroundColor: .systemGray4, course: "1"),
        ])
    }
    
    func getCurrentDate(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        Data.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
    }
    
    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    
    @IBAction func settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as?
            HomeTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configue(with: model)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

}
