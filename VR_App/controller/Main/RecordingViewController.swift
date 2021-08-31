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
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        cancelSpeechRecognition()
    }


    @IBAction func onTapCancel(_ sender: Any) {
        pauseTimer()
        cancelRecordingAlert(msg: "Are you sure you want to cancel this transcript recording?")
       
    }
    @IBAction func onTapSave(_ sender: Any) {
        pauseTimer()
        saveRecordingAlert(msg: "Do you really want to save this transcript?")
    }
    func cancelRecordingAlert(msg:String){
        let alert = UIAlertController(title: "Cancel transcription", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.cancelSpeechRecognition()
            self.stopTimer()
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
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel,handler: { _ in
            self.startTimer()
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
            let node = audioEngine.inputNode
        //  Remove tap first.
            node.removeTap(onBus: 0)
            let recordingFormat = node.outputFormat(forBus: 0)
//            let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                self.request.append(buffer)
            }
    //        prepare audio engine
            audioEngine.prepare()
            do {
                try audioEngine.start()
            } catch _ {
                showAlert(message : "Something went wrong starting audio listener!")
            }
            
            guard let myRecognition = SFSpeechRecognizer() else {
                self.showAlert(message: "Recognition isn't in your local")
                return
            }
            if !myRecognition.isAvailable{
                showAlert(message: "Recognition isn't free right now. Please try again sometime")
            }
    //        start recognizing
            task = speechRecognizer?.recognitionTask(with: request, resultHandler: { response, error in
                guard let response = response else {
                    if error != nil {
                        print("\(error.debugDescription)")
                    }else{
                        self.showAlert(message: "Something went wrong in getting audio response!")
                    }
                   
                    return
                }
    //            gets transcription text
                let message = response.bestTranscription.formattedString
                
                print("message: \(message) ")
                self.spokenTextArea.text = message
                self.transcription = message
                
            })
        }
    //    MARK: - cancel speech recognition
        func cancelSpeechRecognition(){
            if let audiotask = task{
                audiotask.finish()
                audiotask.cancel()
            }
            task = nil
            request.endAudio()
            audioEngine.stop()
            let input_Node = audioEngine.inputNode
            if (input_Node.inputFormat(forBus: 0).channelCount == 0){
                NSLog("Not enough available inputs!")
            }
            input_Node.removeTap(onBus: 0)
            audioEngine.reset()
            
        }
}
