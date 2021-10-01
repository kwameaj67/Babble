//
//  RecordingViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import Speech

class RecordingViewController: UIViewController {
    
    @IBOutlet var spokenTextArea: UITextView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var fractionLabel: UILabel!
    @IBOutlet var stopRecordingButton: UIButton!
    
    var delegate: TranscriptionListDelegate?
    
    //    MARK: - timer local properties
    var timer = Timer()
    var (hours,minutes,seconds,fractions) = (0,0,0,0)
    
    //  MARK: - speech local properties
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask! = nil
    var transcription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerFormat()
        startTimer()
        startSpeechRecognition()
        hideBottomBar()
        roundCorners(button: stopRecordingButton)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        cancelSpeechRecognition()
    }
    
    
    @IBAction func onTapStopRecording(_ sender: Any) {
        animatePulseButton(stopRecordingButton)
        stopRecordingButton.isSelected = !stopRecordingButton.isSelected
        if stopRecordingButton.isSelected{
            cancelSpeechRecognition()
            stopRecordingButton.setTitle("Start recording", for: .normal)
        }else{
            startSpeechRecognition()
            stopRecordingButton.setTitle("Stop recording", for: .normal )
        }
        
    }
    @IBAction func onTapCancel(_ sender: Any) {
        pauseTimer()
        cancelRecordingAlert(msg: "Are you sure you want to cancel this transcript recording?")
        
    }
    //    MARK:- method to save transcription
    @IBAction func onTapSave(_ sender: Any) {
        pauseTimer()
        saveRecordingAlert(msg: "Do you really want to save this transcript?")
    }
    
    private func createTranscription() {
        CoreDataManager.shared.createTranscription(title: "Untitled transcription", text: spokenTextArea.text ?? "")
        delegate?.refreshTranscriptions()
        
    }
    func cancelRecordingAlert(msg:String){
        let alert = UIAlertController(title: "Cancel transcription", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.cancelSpeechRecognition()
            self.dismiss(animated: true, completion: nil)
            print("Timer:\(self.hourLabel.text ?? "")\(self.minuteLabel.text ?? "")\(self.secondLabel.text ?? "")\(self.fractionLabel.text ?? "")\nTranscription:\(self.transcription ?? "")")
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel,handler: { _ in
            self.startTimer()
        }))
        present(alert, animated: true, completion: nil)
    }
    func saveRecordingAlert(msg:String){
        let alert = UIAlertController(title: "Save changes", message: msg, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            //            save transcription here.
            self.createTranscription()
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel,handler: { _ in
            self.startTimer()
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}

extension RecordingViewController{
    //   MARK: - hide bottomLine
    func hideBottomBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    //  MARK: - alerts
    func showAlert(message:String){
        let alert = UIAlertController(title: "Oops!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    //    MARK:- Timer functions
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    func pauseTimer(){
        timer.invalidate()
    }
    func timerFormat(){
        let secondString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minuteString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        let hourString = hours > 9 ? "\(hours)" : "0\(hours)"
        let fractionString = "\(fractions)"
        
        hourLabel.text = "\(hourString):"
        minuteLabel.text = "\(minuteString):"
        secondLabel.text = "\(secondString)."
        fractionLabel.text = "\(fractionString)"
    }
    @objc func updateTimer(){
        fractions += 1
        if fractions > 99{
            seconds += 1
            fractions = 0
        }
        if seconds > 59{
            minutes += 1
            seconds = 0
        }
        if minutes > 59 {
            hours += 1
            minutes = 0
        }
        timerFormat()
        
    }
    
    func stopTimer(){
        timer.invalidate()
        (hours,minutes,seconds,fractions) = (0,0,0,0)
        hourLabel.text = "0\(hours):"
        minuteLabel.text = "0\(minutes):"
        secondLabel.text = "0\(seconds)."
        fractionLabel.text = "0\(fractions)"
    }
    //    MARK: - start speech recognition
    func startSpeechRecognition(){
        startTimer()
        SpeechRecognitionManager.shared.recordSpeech { results in
            switch results{
            case .failure(.noAudioListener):
                self.showAlert(message : "Something went wrong starting audio listener!")
            case .failure(.localRecognition):
                self.showAlert(message: "Recognition isn't in your local")
            case .failure(.busyRecognition):
                self.showAlert(message: "Recognition isn't free right now. Please try again sometime")
            case .failure(.noAudioResponse):
                self.showAlert(message: "Something went wrong in getting audio response!")
            case .success(let data):
                self.spokenTextArea.text = data
                self.transcription = data
            }
        }
        
    }
    //    MARK: - cancel speech recognition
    func cancelSpeechRecognition(){
      
        SpeechRecognitionManager.shared.stopSpeech { results in
            switch results{
            case .success():
                print("recording stopped!")
                self.stopTimer()
            case .failure(_):
                return ()
            }
        }
        
    }
}
