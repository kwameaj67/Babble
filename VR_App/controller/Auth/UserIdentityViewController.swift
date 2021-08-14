//
//  UserIdentityViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class UserIdentityViewController: UIViewController {
    let othersIdentity = ["I am Deaf and Dumb 🦻🏻","I have little hearing impairment","I can hear well 👂🏻"]

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var deafButton: UIButton!
    @IBOutlet weak var dumbButton: UIButton!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var identityTextField: UITextField!
    let identityPicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        deafButton.isSelected = false
        dumbButton.isSelected = false
        
        identityPicker.dataSource = self
        identityPicker.delegate = self
        Styles()
        createIdentityPicker()
    }
    func Styles(){
        roundCorners(button: doneButton)
        roundCorners(button: deafButton)
        roundCorners(button: dumbButton)
        textInputRoundCorners(view: inputContainer)
        otherCornerStyles(btn1: deafButton, btn2: dumbButton)
    }
    func otherCornerStyles(btn1:UIButton,btn2:UIButton){
        btn1.layer.borderColor = Constants.Colors.CGgreen
        btn2.layer.borderColor = Constants.Colors.CGgreen
        btn1.layer.borderWidth = 1.0
        btn2.layer.borderWidth = 1.0
        
    }
    
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onSelectIdentity))
        done.tintColor = Constants.Colors.green
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onCancel))
        cancel.tintColor = Constants.Colors.green
        toolbar.setItems([done,space,cancel], animated: true)
        return toolbar
    }
    
    @objc func onSelectIdentity(){
        identityTextField.resignFirstResponder()
    }
    @objc func onCancel(){
        identityTextField.text = ""
        identityTextField.resignFirstResponder()
        
    }
    func createIdentityPicker(){
        identityTextField.inputView = identityPicker
        identityTextField.inputAccessoryView = createToolBar()
    }
    @IBAction func onTapDoneButton(_ sender: Any) {
        PresenterManager.shared.showViewController(vc: .mainTabController)
    }
    
    @IBAction func onTapIndentityInput(_ sender: Any) {
        identityTextField.resignFirstResponder()
    }
    @IBAction func onTapDeafButton(_ sender: Any) {
    }
    
    @IBAction func onTapDumbButton(_ sender: Any) {
    }
}

extension UserIdentityViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return othersIdentity.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return othersIdentity[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.black
        pickerLabel.text = othersIdentity[row]
        pickerLabel.font = UIFont(name: "Avenir", size: 14.0)
        pickerLabel.font = UIFont.boldSystemFont(ofSize: 20) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        identityTextField.text = othersIdentity[row]
    }
}
