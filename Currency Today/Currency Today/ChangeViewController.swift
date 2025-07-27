//
//  ChangeViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit
class ChangeOption {
    var name: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    var api: String
    
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage, api: String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
    }
}

class ChangeViewController: UIViewController {

    @IBOutlet weak var Change: UINavigationBar!
    @IBOutlet weak var TableView: UITableView!
    var modals = [ChangeOption]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(ChangeTableViewCell.self, forCellReuseIdentifier: ChangeTableViewCell.identifier)
        configure()
    }
    
    func configure(){
        modals.append(contentsOf: [
            ChangeOption(name: "AMD", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Armenia")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ChangeOption(name: "USD", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Unitade States")!, api: "https://open.er-api.com/v6/latest/USD"),
            ChangeOption(name: "RUB", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Russia")!, api:
                "https://open.er-api.com/v6/latest/RUB"),
            ChangeOption(name: "CNY", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_China")!, api:
                "https://open.er-api.com/v6/latest/CNY"),
            ChangeOption(name: "JPY", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Japan")!, api:
                "https://open.er-api.com/v6/latest/JPY"),
            ChangeOption(name: "ARS", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Argentina")!, api:
                "https://open.er-api.com/v6/latest/ARS"),
            ChangeOption(name: "BGN", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Bulgaria")!, api:
                "https://open.er-api.com/v6/latest/BGN"),
            ChangeOption(name: "CAD", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Canada")!, api:
                "https://open.er-api.com/v6/latest/CAD"),
            ChangeOption(name: "CHF", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Switzerland")!, api:
                "https://open.er-api.com/v6/latest/CHF"),
            ChangeOption(name: "BDT", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Bangladesh")!, api:
                "https://open.er-api.com/v6/latest/BDT"),
            ChangeOption(name: "GEL", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Georgia")!, api:
                "https://open.er-api.com/v6/latest/GEL"),
            ChangeOption(name: "BYN", backgroundColor: .systemGray4, backgroundImage: UIImage(named: "Flag_of_Belarus")!, api:
                "https://open.er-api.com/v6/latest/BYN"),
            
            
            
        ])
    }
  
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
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

extension ChangeViewController: UITableViewDelegate,
          UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modal = modals[indexPath.row]
        guard let cell =
                tableView.dequeueReusableCell(withIdentifier: ChangeTableViewCell.identifier, for: indexPath) as? ChangeTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: modal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.TableView.deselectRow(at: indexPath, animated: true)
        if modals[indexPath.item].name != "" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController
            vc?.ap = modals[indexPath.item].api
            vc?.text = modals[indexPath.item].name
            self.present(vc!,animated: true)
            
        }
    }
}
