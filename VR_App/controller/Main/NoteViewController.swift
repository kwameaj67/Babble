//
//  NotePadViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 21/08/2021.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDate()
        hideBottomBar()
    }
    

    @IBAction func onTapClose(_ sender: Any) {
        if topicTextField.text?.isEmpty == false || noteTextField.text.isEmpty == false{
            showAlert(msg: "You've made changes. Do you want to save them before leaving this page?")
        }else{
            dismiss(animated: true, completion: nil)
        }
       
    }
}
extension NoteViewController{
//    MARK:- datetime
    func currentDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        formatter.dateFormat = "EEEE, MMMM d,yyyy"
        
        let curr = formatter.string(from: date)
        dateLabel.text = curr
    }
//    hide bottomLine
    func hideBottomBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
//    show alert
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Save changes", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Don't save", style: .cancel,handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
