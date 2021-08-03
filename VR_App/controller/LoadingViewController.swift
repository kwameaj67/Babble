//
//  ViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 02/08/2021.
//

import UIKit

class LoadingViewController: UIViewController {

    private let isLoggedIn = true
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showInitialView()
        }
            }
    
    private func setupViews(){
        view.backgroundColor = .systemGray
    }
    
    private func showInitialView(){
//  if user is logged in, shows tabBar controller
//  if user is NOT logged in, show onboarding flow
        if isLoggedIn {
            let tabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainTabController")
            if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window{
                window.rootViewController = tabBarController
            }
        }else{
            performSegue(withIdentifier: "showOnboarding", sender: nil)
        }
    }

}

