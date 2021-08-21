//
//  GenderViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit


class GenderViewController: UIViewController {
    
    let otherGenders = ["Transexual Man","Transexual Woman","Transgender Man","Transgender Woman","Neither"]
    var userGender:String = ""
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var InputContainer: UIView!
    @IBOutlet weak var genderTextField: UITextField!
    var genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styles()
        otherCornerStyles(btn1: maleButton, btn2: femaleButton)
        createGenderPicker()
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserIdentityViewController
        let myGender = userGender
        
        destinationVC.gender = myGender
    }
    
    func styles(){
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
        animatePulseButton(maleButton)
        maleButton.isSelected = !maleButton.isSelected
        if  maleButton.isSelected{
            selectedMale()
            deSelectedFemale()
            userGender = "Male"

        }else{
            deSelectedMale()
        }
        print(userGender)
    }
    @IBAction func onTapFemale(_ sender: Any) {
        animatePulseButton(femaleButton)
        femaleButton.isSelected = !femaleButton.isSelected
        if  femaleButton.isSelected{
            selectedFemale()
            deSelectedMale()
            userGender = "Female"
          
        }else{
            deSelectedFemale()
            
        }
        print(userGender)
    }
    
    func selectedMale(){
        maleButton.setTitle("I am male", for: .normal)
        maleButton.layer.borderWidth = 0.0
        maleButton.layer.backgroundColor = Constants.Colors.CGgreen
        maleButton.setTitleColor(Constants.Colors.white,for: .normal)
        femaleButton.isSelected = false
        
       
        
    }
    func deSelectedMale(){
        maleButton.setTitle("👦🏻  Male", for: .normal)
        maleButton.layer.borderWidth = 1.0
        maleButton.layer.backgroundColor = Constants.Colors.CGwhite
        maleButton.layer.borderColor = Constants.Colors.CGgreen
        maleButton.setTitleColor(.systemGray3,for: .normal)
        femaleButton.isSelected = false
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
        
        if userGender.isEmpty{
            showAlert(message: "Please choose your gender 🙄")
        }
       
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
        deSelectedFemale()
        deSelectedMale()
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
//        self.view.isUserInteractionEnabled = false
        genderTextField.resignFirstResponder()
    }
}

extension GenderViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return otherGenders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return otherGenders[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
        {
            let pickerLabel = UILabel()
            pickerLabel.textColor = UIColor.black
            pickerLabel.text = otherGenders[row]
            pickerLabel.font = UIFont(name: "Avenir", size: 14.0)
            pickerLabel.font = UIFont.boldSystemFont(ofSize: 20) // In this use your custom font
            pickerLabel.textAlignment = NSTextAlignment.center
            return pickerLabel
        }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = otherGenders[row]
        userGender =  genderTextField.text ?? ""
        print(userGender)
     
//        genderTextField.resignFirstResponder()
    }
    func showAlert(message:String){
        let alert = UIAlertController(title: "Sorry!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
