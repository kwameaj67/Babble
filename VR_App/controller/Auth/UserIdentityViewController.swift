//
//  UserIdentityViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class UserIdentityViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Styles()
    }
    func Styles(){
        roundCorners(button: doneButton)
    }
    
    @IBAction func onTapDoneButton(_ sender: Any) {
        PresenterManager.shared.showViewController(vc: .mainTabController)
    }
    
    

}
