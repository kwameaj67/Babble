//
//  ViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 02/08/2021.
//

import UIKit
import FirebaseAuth
class LoadingViewController: UIViewController {

    private var isLoggedIn:Bool {
        return  (Auth.auth().currentUser != nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let data =  userDefaults.getStoreUserData
        print(data ?? "")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delay(duration: 2.0) {
            self.showInitialView()
        }
    }
    
  
    
    private func showInitialView(){
//  if user is logged in, shows tabBar controller
//  if user is NOT logged in, show onboarding flow
        if isLoggedIn {
            PresenterManager.shared.showViewController(vc: .mainTabController)
        }
        else{
            PresenterManager.shared.showViewController(vc: .onboarding)
        }
    }
    
   

}

