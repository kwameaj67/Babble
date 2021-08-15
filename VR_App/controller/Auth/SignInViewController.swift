//
//  SignInViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var nameFieldContainer: UIView!
    @IBOutlet weak var passwordFieldContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var showPwdButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Styles()
        nameTextField.becomeFirstResponder()
        scrollView.showsVerticalScrollIndicator = false

    }
    func Styles(){
        roundCorners(button: loginButton)
        roundCorners(button: googleButton)
        textInputRoundCorners(view: nameFieldContainer)
        textInputRoundCorners(view: passwordFieldContainer)
        
        googleButton.layer.borderWidth = 1.0
        googleButton.layer.borderColor = Constants.Colors.CGgreen
        googleButton.layer.backgroundColor = Constants.Colors.CGwhite
        googleButton.setTitleColor(Constants.Colors.green, for: .normal)
    }


    @IBAction func onTapLogin(_ sender: Any) {
        animatePulseButton(loginButton)
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.genderController)as! GenderViewController
        navigationController?.pushViewController(vc, animated: true)
        
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
    @IBAction func onTapShowPwd(_ sender: UIButton) {
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
    @IBAction func onTapSignup(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.signupController)as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapGoogleButton(_ sender: Any) {
        animatePulseButton(googleButton)
    }
}
