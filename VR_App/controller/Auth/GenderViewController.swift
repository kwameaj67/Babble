//
//  GenderViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit

class GenderViewController: UIViewController {
    let genders = ["Transexual Man","Transexual Woman","Transgender Man","Transgender Woman","Neither"]
  
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var InputContainer: UIView!
    @IBOutlet weak var genderTextField: UITextField!
    var genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Styles()
        otherCornerStyles(btn1: maleButton, btn2: femaleButton)
        createGenderPicker()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
        
    }
    
    func Styles(){
        roundCorners(button: maleButton)
        roundCorners(button: femaleButton)
        roundCorners(button: continueButton)
        textInputRoundCorners(view: InputContainer)
    }
    func otherCornerStyles(btn1:UIButton,btn2:UIButton){
        btn1.layer.borderColor = Constants.Colors.CGgreen
        btn2.layer.borderColor = Constants.Colors.CGgreen
        btn1.layer.borderWidth = 1.0
        btn2.layer.borderWidth = 1.0
        
    }

   
    @IBAction func onTapMale(_ sender: Any) {
        maleButton.isSelected = !maleButton.isSelected
        if  maleButton.isSelected{
           selectedMale()
            deSelectedFemale()
        }else{
            deSelectedMale()
        }
    }
    @IBAction func onTapFemale(_ sender: Any) {
        femaleButton.isSelected = !femaleButton.isSelected
        if  femaleButton.isSelected{
            selectedFemale()
            deSelectedMale()
        }else{
            deSelectedFemale()
        }
    }
    
    func selectedMale(){
        maleButton.setTitle("I am male", for: .normal)
        maleButton.layer.backgroundColor = Constants.Colors.CGgreen
        maleButton.layer.borderWidth = 0.0
        maleButton.setTitleColor(Constants.Colors.white,for: .normal)
        femaleButton.isSelected = false
    }
    func deSelectedMale(){
        maleButton.setTitle("👦🏻  Male", for: .normal)
        maleButton.layer.borderWidth = 1.0
        maleButton.layer.backgroundColor = Constants.Colors.CGwhite
        maleButton.layer.borderColor = Constants.Colors.CGgreen
        maleButton.setTitleColor(.systemGray3,for: .normal)
    }
    func selectedFemale(){
        femaleButton.setTitle("I am Female", for: .normal)
        femaleButton.layer.backgroundColor = Constants.Colors.CGgreen
        femaleButton.layer.borderWidth = 0.0
        femaleButton.setTitleColor(Constants.Colors.white,for: .normal)
        maleButton.isSelected = false
    }
    func deSelectedFemale(){
        femaleButton.setTitle("👩🏻  Female", for: .normal)
        femaleButton.layer.borderWidth = 1.0
        femaleButton.layer.backgroundColor = Constants.Colors.CGwhite
        femaleButton.layer.borderColor = Constants.Colors.CGgreen
        femaleButton.setTitleColor(.systemGray3,for: .normal)
        maleButton.isSelected = false
    }
    @IBAction func onTapContinue(_ sender: Any) {
    animatePulseButton(continueButton)
        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.identityController) as! UserIdentityViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createToolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(onSelectGender))
        done.tintColor = Constants.Colors.green
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onCancelGender))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)  // add spaces to bar items
        cancel.tintColor = Constants.Colors.green
        toolBar.setItems([done,flexibleSpace,cancel], animated: true)
        toolBar.layer.backgroundColor = Constants.Colors.CGwhite
        return toolBar
    }
    @objc func onSelectGender(){
        genderTextField.resignFirstResponder()
        maleButton.isSelected = false
        femaleButton.isSelected = false
    }
    @objc func onCancelGender(){
        genderTextField.resignFirstResponder()
        genderTextField.text = ""
    }
    func createGenderPicker(){
        genderTextField.inputView = genderPicker
        genderTextField.inputAccessoryView = createToolBar()
    }
    
    @IBAction func onTapGenderField(_ sender: Any) {
        genderTextField.resignFirstResponder()
    }
}

extension GenderViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
        {
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor.black
            pickerLabel.text = genders[row]
            pickerLabel.font = UIFont(name: "Avenir-Regular", size: 14.0)
            pickerLabel.font = UIFont.boldSystemFont(ofSize: 20) // In this use your custom font
            pickerLabel.textAlignment = NSTextAlignment.center
            return pickerLabel
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
        deSelectedFemale()
        deSelectedMale()
//        genderTextField.resignFirstResponder()
    }
    
    
}
