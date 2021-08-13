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
    @IBOutlet weak var confirmPasswordFieldContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var showPwdButton: UIButton!
    @IBOutlet weak var showPwdButton2: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmPasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        scrollView.showsVerticalScrollIndicator = false
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        Styles()
        
        
    }
    
    
    func Styles(){
        textInputRoundCorners(view: nameFieldContainer)
        textInputRoundCorners(view: emailFieldContainer)
        textInputRoundCorners(view: passwordFieldContainer)
        textInputRoundCorners(view: confirmPasswordFieldContainer)
        inputConfig(input: nameTextField)
        inputConfig(input: emailTextField)
        inputConfig(input: passwordTextField)
        inputConfig(input: confirmPasswordTextField)
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

    @IBAction func validateConfirmPassword(_ sender: Any) {
        let password = passwordTextField.text ?? ""
        let password2 = confirmPasswordTextField.text ?? ""
        
        if password2.isEmpty {
            confirmPasswordError.isHidden = true
        }else{
            confirmPasswordError.isHidden = false
        }
        if (password2.isValidPassword() && password == password2){
            confirmPasswordError.textColor = Constants.Colors.green
            confirmPasswordError.text = "Password valid ✅"
        }else if(password != password2){
            confirmPasswordError.textColor = Constants.Colors.red
            confirmPasswordError.text = "Passwords do not match. Check again❌"
        }else if(!password2.isValidPassword()){
            confirmPasswordError.textColor = Constants.Colors.red
            confirmPasswordError.text = "Password must have small, capital characters & numbers from 6-15 ❌"
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
    @IBAction func toggleSecureTextEntry2(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            confirmPasswordTextField.isSecureTextEntry = true
            showPwdButton2.setTitle("Hide", for: .normal)
        }else if sender.tag == 1{
            sender.tag = 0
            showPwdButton2.setTitle("Show", for: .normal)
            confirmPasswordTextField.isSecureTextEntry = false
        }
    }
    @IBAction func goToSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.signupController) as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.signinController) as! SignInViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapSignup(_ sender: Any) {
        animatePulseButton(signupButton)
    }
}
