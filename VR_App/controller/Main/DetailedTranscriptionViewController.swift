//
//  DetailedTranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 08/09/2021.
//

import UIKit

class DetailedTranscriptionViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextArea: UITextView!
    var noteDate: String = ""
    var noteTitle:String = ""
    var noteDescription:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Files"
        dateLabel.text = noteDate
        titleTextField.text = noteTitle
        descriptionTextArea.text = noteDescription
    }

}
