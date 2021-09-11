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
    
    var delegate: TranscriptionListDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDate()
        hideBottomBar()
        topicTextField.becomeFirstResponder()
    }
    

    @IBAction func onTapClose(_ sender: Any) {
        if topicTextField.text?.isEmpty == false || noteTextField.text.isEmpty == false{
            showCancelAlert(msg: "You've made changes. Do you want to cancel transcription note?")
        }else{
            dismiss(animated: true, completion: nil)
        }
       
    }
    @IBAction func onTapSave(_ sender: Any) {
        saveRecordingAlert(msg: "Do you want to save?")
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
//    save notes
    private func createTranscription() -> Transcriptions{
        let note = CoreDataManager.shared.createTranscription(title: topicTextField.text ?? "Untitled transcription", text: noteTextField.text ?? "")
        delegate?.refreshTranscriptions()
        return note
    }

//    show cancel alert
    func showCancelAlert(msg:String){
        let alert = UIAlertController(title: "Cancel transcription note", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .destructive,handler: { _ in
            
        }))
        present(alert, animated: true, completion: nil)
    }
//    show save note alert
    func saveRecordingAlert(msg:String){
        let alert = UIAlertController(title: "Save changes", message: msg, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
//            save transcription here.
            self.createTranscription()
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel,handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}
