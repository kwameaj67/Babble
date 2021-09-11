//
//  DetailedTranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 08/09/2021.
//

import UIKit

class DetailedTranscriptionViewController: UIViewController {

//    MARK: - variables
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextArea: UITextView!
    
    var transcripts: Transcriptions!
    var delegate: TranscriptionListDelegate?
    
    var noteDate: String = ""
    var noteTitle:String = ""
    var noteDescription:String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        titleTextField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Files"
        dateLabel.text = noteDate
        titleTextField.text = noteTitle
        descriptionTextArea.text = noteDescription
    }
    
    func updateTranscriptions(){
        print("updating note")
        transcripts.date = Date()
        CoreDataManager.shared.saveTranscriptions()
        delegate?.refreshTranscriptions()
    }
    
}
extension DetailedTranscriptionViewController: UITextViewDelegate,UITextFieldDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        transcripts?.text = descriptionTextArea.text
        updateTranscriptions()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        transcripts?.title = titleTextField.text
        updateTranscriptions()
    }
}
