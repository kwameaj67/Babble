//
//  ErrorViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var tryAgainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        hideBottomBar()
       
    }
    

 
    @IBAction func onTapExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTapTryAgain(_ sender: Any) {
    }
    

}

extension ErrorViewController{
    func styles(){
        roundCorners(button: tryAgainButton)
        tryAgainButton.layer.shadowColor = Constants.Colors.CGgreen
        tryAgainButton.layer.shadowRadius = 10
        tryAgainButton.layer.shadowOpacity = 0.2
        tryAgainButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    func hideBottomBar(){
        let navigationBar = navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.isTranslucent = true
        navigationBar?.shadowImage = UIImage()
    }
}
