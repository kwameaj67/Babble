//
//  SignUpViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameFieldContainer: UIView!
    @IBOutlet weak var emailFieldContainer: UIView!
    @IBOutlet weak var passwordFieldContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPwdButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        passwordTextField.isSecureTextEntry = true
        Styles()
        
        
    }
    
    
    func Styles(){
        textInputRoundCorners(view: nameFieldContainer)
        textInputRoundCorners(view: emailFieldContainer)
        textInputRoundCorners(view: passwordFieldContainer)
        inputConfig(input: nameTextField)
        inputConfig(input: emailTextField)
        inputConfig(input: passwordTextField)
        roundCorners(button: signupButton)
    }
   
    @IBAction func validateEmail(_ sender: Any) {
        let email = emailTextField.text ?? ""
        if email.isEmpty {
            emailError.isHidden = true
        }else{
            emailError.isHidden = false
        }
        if email.isValidEmail(){
            emailError.textColor = Constants.Colors.green
            emailError.text = "Email address is valid ✅"
        }else{
            emailError.textColor = Constants.Colors.red
            emailError.text = "Email address not valid ❌"
        }
        
    }
    @IBAction func validatePassword(_ sender: Any) {
        let password = passwordTextField.text ?? ""
        if password.isEmpty {
            passwordError.isHidden = true
        }else{
            passwordError.isHidden = false
        }
        if password.isValidPassword(){
            passwordError.textColor = Constants.Colors.green
            passwordError.text = "Password valid ✅"
        }else{
            passwordError.textColor = Constants.Colors.red
            passwordError.text = "Password must have small, capital characters & numbers from 6-15 ❌"
        }
    }

    @IBAction func toggleSecureTextEntry(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            passwordTextField.isSecureTextEntry = true
            showPwdButton.setTitle("Hide", for: .normal)
        }else if sender.tag == 1{
            sender.tag = 0
            showPwdButton.setTitle("Show", for: .normal)
            passwordTextField.isSecureTextEntry = false
        }
       
    }
}
