//
//  SettingsViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import MBProgressHUD
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapLogoutIcon(_ sender: UIBarButtonItem) {
       showAlert()
    }
    func logoutUser(){
        MBProgressHUD.showAdded(to: view, animated: true)
        delay(duration: 1.0) {
            do {
                try  Auth.auth().signOut()
                print("Logout successfull")
                MBProgressHUD.hide(for: self.view, animated: true )
            } catch let error {
                print(error.localizedDescription)
            }
            PresenterManager.shared.showViewController(vc: .authInit)
        }
    }
    

}

extension SettingsViewController{
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
