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
    
    var gender:String = ""
    var userIdentity:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deafButton.isSelected = false
        dumbButton.isSelected = false
        
        identityPicker.dataSource = self
        identityPicker.delegate = self
        Styles()
        createIdentityPicker()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SignUpViewController
        destinationVC.finalGender = gender
        destinationVC.finalIdentity = userIdentity
        
    }
    func Styles(){
        [doneButton,deafButton,dumbButton].forEach { item in
            roundCorners(button: item)
        }
        textInputRoundCorners(view: inputContainer)
        otherCornerStyles(btn1: deafButton, btn2: dumbButton)
    }
    func otherCornerStyles(btn1:UIButton,btn2:UIButton){
        [btn1,btn2].forEach { item in
            item.layer.borderColor = Constants.Colors.CGgreen
            item.layer.borderWidth = 1.0
        }
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
        deselectDumb()
        deselectDeaf()
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
        animatePulseButton(doneButton)
        if userIdentity.isEmpty{
            showAlert(message: "Please select how you identify 🙄")
        }
    }
    
    @IBAction func onTapIndentityInput(_ sender: Any) {
        identityTextField.resignFirstResponder()
    }
    func selectDeaf(){
        deafButton.setTitle("I am Deaf and use signs🧏🏻‍♀️ ✅", for: .normal)
        dumbButton.isSelected = false
    }
    func deselectDeaf(){
        deafButton.setTitle("I am Deaf and use signs🧏🏻‍♀️", for: .normal)
        dumbButton.isSelected = false
    }
    func selectDumb(){
        dumbButton.setTitle("I am Dumb and use signs 🧏🏻‍♂️ ✅", for: .normal)
        deafButton.isSelected = false
    }
    func deselectDumb(){
        dumbButton.setTitle("I am Dumb and use signs 🧏🏻‍♂️", for: .normal)
        deafButton.isSelected = false
    }
    @IBAction func onTapDeafButton(_ sender: Any) {
        animatePulseButton(deafButton)
        deafButton.isSelected = !deafButton.isSelected
        if deafButton.isSelected{
            selectDeaf()
            deselectDumb()
            userIdentity = "I am Deaf and use signs"
            print(userIdentity)
        }else{
            deselectDeaf()
        }
    }
    
    @IBAction func onTapDumbButton(_ sender: Any) {
        animatePulseButton(dumbButton)
        dumbButton.isSelected = !dumbButton.isSelected
        if dumbButton.isSelected{
            selectDumb()
            deselectDeaf()
            userIdentity = "I am Dumb and use signs"
            print(userIdentity)
        }else{
            deselectDumb()
        }
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
        userIdentity = identityTextField.text ?? ""
        identityTextField.resignFirstResponder()
        deselectDumb()
        deselectDeaf()
        print(userIdentity)
    }
    func showAlert(message:String){
        let alert = UIAlertController(title: "Sorry!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
