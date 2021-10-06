//
//  SignUpViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import MBProgressHUD
import FirebaseAuth

class SignUpViewController: UIViewController {

    private let authManager = AuthManager()
    
    var finalGender: String = ""
    var finalIdentity:String = ""
    var finalUuid:String = ""
    
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
    @IBOutlet weak var googleSignupButton: UIButton!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmPasswordError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
//        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
//         view.addGestureRecognizer(tapGesture)
        scrollView.showsVerticalScrollIndicator = false
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        styles()
        print("\(finalGender)\n\(finalIdentity)")
        addToolBarToFields()
        
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
        if nameTextField.isEditing{
            nameTextField.resignFirstResponder()
        }else if emailTextField.isEditing{
            emailTextField.resignFirstResponder()
        }else if passwordTextField.isEditing{
            passwordTextField.resignFirstResponder()
        }else if confirmPasswordTextField.isEditing{
            confirmPasswordTextField.resignFirstResponder()
        }
    }
    func addToolBarToFields(){
        [nameTextField,emailTextField,passwordTextField,confirmPasswordTextField].forEach { item in
            item?.inputAccessoryView = createToolBar()
        }
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
            delay(duration: 1.0) {
                self.emailError.isHidden = true
            }
        }else{
            emailError.textColor = Constants.Colors.red
            emailError.text = "Incorrect email was entered ❌"
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
            delay(duration: 1.0) {
                self.passwordError.isHidden = true
            }
        }else{
            passwordError.textColor = Constants.Colors.red
            passwordError.text = "Password must have small, capital characters & numbers from 6-15"
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
            delay(duration: 1.0) {
                self.confirmPasswordError.isHidden = true
            }
        }else if(password != password2){
            confirmPasswordError.textColor = Constants.Colors.red
            confirmPasswordError.text = "Passwords do not match. Check again❌"
        }else if(!password2.isValidPassword()){
            confirmPasswordError.textColor = Constants.Colors.red
            confirmPasswordError.text = "Password must have small, capital characters & numbers from 6-15 "
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
    @IBAction func onTapLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.signinController) as! SignInViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onTapSignup(_ sender: Any) {
        
        animatePulseButton(signupButton)
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password1 = passwordTextField.text ?? ""
        let password2 = confirmPasswordTextField.text ?? ""
        
        
        if(name == "") {
            showAlert(message: "Please enter your name")
        }else if(email == ""){
            showAlert(message: "Please enter your email address")
        }else if(password1 == ""){
            showAlert(message: "Please enter a unique password")
        }
//        else if(password2 == ""){
//            showAlert(message: "Please re-type your unique password")
//        }else if(password1 != password2){
//            showAlert(message: "Passwords do not match. Kindly check again❌")
//        }
        else if(!email.isValidEmail()){
            showAlert(message: "Email address is not valid.")
        }
        else if(!password1.isValidPassword() ){
            showAlert(message: "Password is not valid.")
        }else if(email.isValidEmail() && password1.isValidPassword()){
            MBProgressHUD.showAdded(to: view, animated: true)
            print("Name:\(name)\nEmail:\(email)\nPassword: \(password1)")
            authManager.signUpUser(withEmail: email, password: password1) { [weak self] (result) in
                switch result{
                case .failure(let error):
                    self!.showAlert(message: "\(error.localizedDescription)")
                    print(error)
                    MBProgressHUD.hide(for: self!.view, animated: true)
                case .success(let user):
                    print("UserId:\(user.uid)\nEmail:\(user.email!)")
                    self?.finalUuid = user.uid
                    self?.setUserDefaults()
                    self?.createFireStoreUser()
                   
                }
            }
        }
    }
    func createFireStoreUser(){
        authManager.createUserCollection(email:  emailTextField.text ?? "", gender: finalGender, username: nameTextField.text ?? "", identity: finalIdentity, uid: finalUuid) { (result) in
            switch result{
            case .failure(let error):
                self.showAlert(message: error.localizedDescription)
                MBProgressHUD.hide(for: self.view, animated: true)
                print("Firestore error")
            case .success():
                print("User add to fireStore successfully")
                MBProgressHUD.hide(for: self.view, animated: true)
                
                PresenterManager.shared.showViewController(vc: .mainTabController)
            }
        }
    }
    @IBAction func onTapGoogleSignUp(_ sender: Any) {
        animatePulseButton(googleSignupButton)
    }
}

extension SignUpViewController{
    func showAlert(message:String){
        let alert = UIAlertController(title: "Oops!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func styles(){
        textInputRoundCorners(view: nameFieldContainer)
        textInputRoundCorners(view: emailFieldContainer)
        textInputRoundCorners(view: passwordFieldContainer)
        textInputRoundCorners(view: confirmPasswordFieldContainer)
        inputConfig(input: nameTextField)
        inputConfig(input: emailTextField)
        inputConfig(input: passwordTextField)
        inputConfig(input: confirmPasswordTextField)
        roundCorners(button: signupButton)
        roundCorners(button: googleSignupButton)
        
        googleSignupButton.layer.borderWidth = 1.0
        googleSignupButton.layer.borderColor = Constants.Colors.CGgreen
        
    }
    func setUserDefaults(){
        let user = [
            "email":emailTextField.text ?? "",
            "username":nameTextField.text ?? "",
            "gender":self.finalGender,
            "identity":self.finalIdentity,
            "uuid":self.finalUuid,
        ]
        userDefaultManager.userDefault.set(user, forKey: "user")
        print("user data saved in defaults\n\(user)")
    }
    
}

// 
