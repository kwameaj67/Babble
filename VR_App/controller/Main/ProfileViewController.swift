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
        profileTableView.layer.cornerRadius = 20
        profileTableView.separatorStyle = .none
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCell.profile) as? ProfileTableViewCell else {
            fatalError("ProfileTableViewCell not found")
        }
        let item = profileItems.items[indexPath.row]
        cell.setupProfile(with: item)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = profileItems.items[indexPath.row]
        print("\(item.profileOptions.rawValue)")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
