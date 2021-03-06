//
//  SignInViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import MBProgressHUD
import FirebaseAuth

class SignInViewController: UIViewController {
    private let authManager = AuthManager()

    @IBOutlet weak var emailFieldContainer: UIView!
    @IBOutlet weak var passwordFieldContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var  emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var showPwdButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Styles()
        emailTextField.becomeFirstResponder()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        scrollView.showsVerticalScrollIndicator = false
        addToolBarToFields()
        
    }
    func Styles(){
        roundCorners(button: loginButton)
        roundCorners(button: googleButton)
        textInputRoundCorners(view: emailFieldContainer)
        textInputRoundCorners(view: passwordFieldContainer)
        
        googleButton.layer.borderWidth = 1.0
        googleButton.layer.borderColor = Constants.Colors.CGgreen
        googleButton.layer.backgroundColor = Constants.Colors.CGwhite
        googleButton.setTitleColor(Constants.Colors.green, for: .normal)
    }

    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: nil, action: #selector(onDone))
        done.tintColor = Constants.Colors.green
        toolbar.setItems([space1,space2,done], animated: true)
                                   
        return toolbar
    }
   
    @objc func onDone(){
        if emailTextField.isEditing{
            emailTextField.resignFirstResponder()
        }else if passwordTextField.isEditing{
            passwordTextField.resignFirstResponder()
        }
    }
    func addToolBarToFields(){
        [emailTextField,passwordTextField].forEach { item in
            item?.inputAccessoryView = createToolBar()
        }
    }
    @IBAction func validateEmail(_ sender: Any) {
        let email = emailTextField.text ?? ""
        
        if email.isEmpty{
            emailError.isHidden = true
        }else{
            emailError.isHidden = false
        }
        if email.isValidEmail(){
            emailError.textColor = Constants.Colors.green
            emailError.text = "Email address is valid ???"
            delay(duration: 1.0) {
                self.emailError.isHidden = true
            }
        }else{
            emailError.textColor = Constants.Colors.red
            emailError.text = "Incorrect email was entered ???"
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
            passwordError.text = "Password valid ???"
            delay(duration: 1.0) {
                self.passwordError.isHidden = true
            }
        }else{
            passwordError.textColor = Constants.Colors.red
            passwordError.text = "Password must have small, capital characters & numbers from 6-15 "
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
    @IBAction func onTapLogin(_ sender: Any) {
        animatePulseButton(loginButton)
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if email.isEmpty{
            showAlert(message: "Please enter your email address")
        }else if password.isEmpty{
            showAlert(message: "Please enter your unique password")
        }else if !email.isValidEmail(){
            showAlert(message: "Email address is not valid.")
        }else if !password.isValidPassword(){
            showAlert(message: "Password is not valid.")
        }else if email.isValidEmail() && password.isValidPassword(){
            MBProgressHUD.showAdded(to: view, animated: true)
            authManager.signInUser(withEmail: email, password: password) { [weak self] (result) in
                switch result{
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                    MBProgressHUD.hide(for: self!.view, animated: true)
                case .success(let user ):
                    print("\(user.uid)")   // check if uid matches
                    delay(duration: 2.0) {
                        MBProgressHUD.hide(for: self!.view, animated: true)
                        PresenterManager.shared.showViewController(vc: .mainTabController)
                    }
                }
            }
        }
       
        
    }
    @IBAction func onTapGoogleButton(_ sender: Any) {
        animatePulseButton(googleButton)
    }
    @IBAction func onTapForgotPassword(_ sender: Any) {
       print("move to forgotPassword")
    }
}

extension SignInViewController{
    func showAlert(message:String){
        let alert = UIAlertController(title: "Oops!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
