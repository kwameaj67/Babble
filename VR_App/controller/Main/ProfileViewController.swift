//
//  SettingsViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import MBProgressHUD
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var profileTableView: UITableView!
    private let authManager = AuthManager()
    var profileItems = ProfileItems()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       
    }
    func configureTableView(){
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.tableFooterView = UIView()
        profileTableView.layer.cornerRadius = 10
//        profileTableView.separatorStyle = .none
        profileTableView.showsVerticalScrollIndicator = false
        profileTableView.allowsMultipleSelection = false
        profileTableView.backgroundColor = .clear
        
    }
    @IBAction func onTapLogoutIcon(_ sender: UIBarButtonItem) {
       showAlert()
    }
    func logoutUser(){
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(duration: 1.0) {
            let result = self.authManager.logoutUser()
            switch result{
            case .failure(let error):
                print("\(error.localizedDescription)")
                MBProgressHUD.hide(for: self.view, animated: true )
            case .success():
                print("Logout successfull")
                MBProgressHUD.hide(for: self.view, animated: true )
                PresenterManager.shared.showViewController(vc: .authInit)
            }
        
        }
    }
}
extension ProfileViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.sectionArray.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.sectionArray[section].sectionName.uppercased()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 40, width: tableView.frame.width, height: 60))
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        let label = UILabel(frame: CGRect(x: 0, y: -5, width: Int(view.frame.width), height: 40))
        label.font = UIFont(name: "Avenir Heavy", size: 12)
        label.textColor = UIColor(red: 0.49, green: 0.49, blue: 0.49, alpha: 1.00)
        label.text = Section.sectionArray[section].sectionName.uppercased()
        view.addSubview(label)
        return view
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.sectionArray[section].sectionItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.profile) as? ProfileTableViewCell else {
            fatalError("ProfileTableViewCell not found")
        }
        let item = Section.sectionArray[indexPath.section].sectionItems[indexPath.row]
        cell.setupProfile(with: item)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Section.sectionArray[indexPath.section].sectionItems[indexPath.row]
        print("\(item.profileOptions.rawValue)")
        if indexPath.row == 0{
//            go to profile screen
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ProfileViewController{
    func showAlert(){
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let Yes = UIAlertAction(title: "Yes", style: .cancel) { _ in
            self.logoutUser()
            self.dismiss(animated: true, completion: nil)
        }
        let No = UIAlertAction(title: "No", style: .default, handler: nil)
        alert.addAction(Yes)
        alert.addAction(No)
        self.present(alert, animated: true, completion: nil)
    }
}
