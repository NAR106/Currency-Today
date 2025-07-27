//
//  SettingsViewController.swift
//  Currency Today
//
//  Created by Student on 18.07.25.
//

import UIKit
class SettingsOption{
    var name:String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}
class SettingsViewController: UIViewController {

    @IBOutlet weak var Settings: UINavigationBar!
    @IBOutlet weak var TableView: UITableView!
    var models = [SettingsOption]()
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        configure()
    }
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About program", backgroundColor: .systemGray4, backgroundImage:UIImage(systemName: "info.circle")!),
            SettingsOption(name: "Share", backgroundColor: .systemGray4, backgroundImage:UIImage(systemName: "arrowshape.turn.up.right")!),
            SettingsOption(name: "Author", backgroundColor: .systemGray4, backgroundImage:UIImage(systemName: "person")!),
            SettingsOption(name: "Contact", backgroundColor: .systemGray4, backgroundImage:UIImage(systemName: "person.circle")!),
           
        ])
    }
    
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
    
    @IBAction func change(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ChangeViewController") as? ChangeViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
}
extension SettingsViewController: UITableViewDelegate,
                                  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as?
                SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        cell.backgroundColor = .systemBlue
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.TableView.deselectRow(at: indexPath, animated: true)
        if models[indexPath.item].name == "Contact" {
            
            let actionSheet = UIAlertController(title: "Contact", message: nil, preferredStyle: .actionSheet)
            
            actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler: { (action) in
                
                UIApplication.shared.open(URL(string: "https://classroom.google.com/c/NzcwNzM1NTE5NDgz")as! URL)
                
            }))
            
            actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
            
            present(actionSheet, animated: true, completion: nil)
            
        } else if models[indexPath.item].name == "Author" {
            
            let alert = UIAlertController(title: "Author", message: "By Narek Hovhannisyan", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "Share" {
            
            let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
            
        }else if models[indexPath.item].name == "About program" {
            
            let alert = UIAlertController(title: "appInfo", message: "This application allows the user to convert money from one currency to another, supporting exchange rates for currencies from different countries. Using the application interface, the user can enter an amount in a given currency and receive the corresponding amount in another currency according to the latest updated exchange rates.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "ok", style: .destructive, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
