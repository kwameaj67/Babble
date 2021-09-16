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
    
    var transcript: Transcriptions!
    var delegate: TranscriptionListDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        titleTextField.becomeFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Files"
        getData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateTranscriptions()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getData(){
        let formatter = DateFormatter()
        let transcriptDate = formatter.string(from: transcript.date!)
        dateLabel.text = transcriptDate   //not working
        titleTextField.text = transcript?.title
        descriptionTextArea.text = transcript?.text
    }
    
    func updateTranscriptions(){
        transcript.date = Date()
        transcript.title = titleTextField.text ?? ""
        transcript.text = descriptionTextArea.text
        CoreDataManager.shared.saveTranscriptions()
        delegate?.refreshTranscriptions()
    }
    
}
extension DetailedTranscriptionViewController: UITextViewDelegate,UITextFieldDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        descriptionTextArea.text =  transcript?.text
        updateTranscriptions()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        titleTextField.text = transcript?.title
        updateTranscriptions()
    }
}
