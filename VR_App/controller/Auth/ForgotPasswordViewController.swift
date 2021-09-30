//
//  ForgotPasswordViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 30/09/2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var emailFieldContainer: UIView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var emailErrorMsg: UILabel!
    @IBOutlet var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func validateEmail(_ sender: Any) {
        let email = emailTextField.text ?? ""
        
        if email.isEmpty{
            emailErrorMsg.isHidden = true
        }else{
            emailErrorMsg.isHidden = false
        }
        if email.isValidEmail(){
            emailErrorMsg.textColor = Constants.Colors.green
            emailErrorMsg.text = "Email address is valid ✅"
            delay(duration: 1.0) {
                self.emailErrorMsg.isHidden = true
            }
        }else{
            emailErrorMsg.textColor = Constants.Colors.red
            emailErrorMsg.text = "Incorrect email was entered ❌"
        }
    }
    
    func styles(){
        textInputRoundCorners(view: emailFieldContainer)
        roundCorners(button: button)
    }
}
