//
//  CustomNavigationViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 09/08/2021.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        makeBarVisible()
     
    }
    
    func makeBarVisible(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }


}
