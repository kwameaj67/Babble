//
//  DetailedTranscriptionViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 08/09/2021.
//

import UIKit
import PDFKit

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
        let moreIcon = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: nil, action: #selector(onTapMore))
        moreIcon.tintColor = Constants.Colors.green
        navigationItem.setRightBarButton(moreIcon, animated: true)
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
    @objc func onTapMore(){
        let actionSheet = UIAlertController(title: "Transcript", message: "\(String(describing: transcript?.title ?? ""))", preferredStyle: .actionSheet)
        
        let pdf = UIAlertAction(title: "Convert to PDF", style: .default) { _ in
            self.convertToPdf()
        }
        
        let pin = UIAlertAction(title: "Pin transcription", style: .default) { _ in
            self.pinTranscription()
        }
        let lock = UIAlertAction(title: "Lock transcription", style: .default) { _ in
            self.lockTranscription()
        }
        let translate = UIAlertAction(title: "Translate", style: .default) { _ in
            self.translateTranscription()
        }
        let share = UIAlertAction(title: "Share", style: .default) { _ in
            self.shareTranscription()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        [pdf,pin,lock,translate,share,cancel].forEach { item in
            actionSheet.addAction(item)
        }
        present(actionSheet, animated: true, completion: nil)
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
    func convertToPdf(){
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [
            kCGPDFContextTitle: "Full Transcript",
            kCGPDFContextAuthor: "\(userDefaultManager.userDetails.name)",
          ]
        format.documentInfo = metaData as [String: Any]
        // A4 would be [W x H] 595 x 842 points
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect,
                                             format: format)
        let data = renderer.pdfData { (context) in
        // Perform your drawing here
            context.beginPage()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            let attributes = [
              NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
              NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let text = "\(transcript?.text ?? "")"
            let textRect = CGRect(x: 100, // left margin
                                  y: 100, // top margin
                              width: 200,
                             height: 20)

            text.draw(in: textRect, withAttributes: attributes)
        }
        let pdfDocument = PDFDocument(data: data)
    }
    func pinTranscription(){
        
    }
    func lockTranscription(){
        
    }
    func translateTranscription(){
        
    }
    func shareTranscription(){
        
    }
}
