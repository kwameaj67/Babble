//
//  PresenterManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit


class PresenterManager {
    static let shared = PresenterManager()
    
    private init(){}
    
    enum VC {
        case mainTabController
        case onboarding
    }
    
    func showViewController(vc:VC){
        var viewController: UIViewController
        switch vc {
        case .mainTabController:
            viewController = UIStoryboard(name:Constants.StoryboardName.tabBarStoryboard, bundle: nil).instantiateViewController (identifier: Constants.StoryboardID.tabBarController)
        case .onboarding:
            viewController = UIStoryboard(name:Constants.StoryboardName.authStoryboard, bundle: nil).instantiateViewController (identifier: Constants.StoryboardID.authController)
        
        }
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window{
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
    
    
}
