//
//  ErrorViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var tryAgainButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
       
    }
    

    @IBAction func onTapTryAgain(_ sender: Any) {
    }
    

}

extension ErrorViewController{
    func styles(){
        roundCorners(button: tryAgainButton)
        tryAgainButton.layer.shadowColor = Constants.Colors.CGgreen
        tryAgainButton.layer.shadowRadius = 10
        tryAgainButton.layer.shadowOpacity = 1
        tryAgainButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
