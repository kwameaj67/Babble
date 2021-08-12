//
//  ViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 02/08/2021.
//

import UIKit

class LoadingViewController: UIViewController {

    private let isLoggedIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
//            let tabBarController = UIStoryboard(name:Constants.StoryboardID.mainStoryboard, bundle: nil).instantiateViewController (identifier: Constants.StoryboardID.tabBarController)
//            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
//                window.rootViewController = tabBarController
//            }
        }else{
            PresenterManager.shared.showViewController(vc: .authInit)
//            performSegue(withIdentifier: Constants.Segue.showOnboarding , sender: nil)
        }
    }
    
   

}

