//
//  HomeViewController.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import Firebase
import AVFoundation

class HomeViewController: UIViewController{

    var isRecording: Bool = false
    var audioData: NSMutableData!
    var timer = Timer()
    var (hours,minutes,seconds,fractions) = (0,0,0,0)
    var captionsTitles:[String] = ["Record your speech","Tap to start captions","Transcribe all captions with a tap"]
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var createNoteButton: UIButton!
    @IBOutlet weak var captionTitleLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet var spokenTextView: UITextView!
    
    @IBOutlet weak var fractionLabel: UILabel!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton(recordButton)
        recordButton.isSelected = false
        delay(duration: 3.0) {
            if let randomCaption = self.captionsTitles.randomElement(){
                self.captionTitleLabel.text = randomCaption
            }
          
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        microphonePermissions()
        styles()
        timerFormat()
        getUserDefaultsData()
        let user = Auth.auth().currentUser?.email
        print(user ?? "user no found")
        AudioController.sharedInstance.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
  
    @IBAction func onTapCreateNote(_ sender: Any) {
        let noteVC = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.noteViewController) as! NoteViewController
        noteVC.modalPresentationStyle = .fullScreen
        present(noteVC, animated: true, completion: nil)
       
    }
    @IBAction func onTapRecordBustton(_ sender: UIButton) {
        
//        pulseSpringAnimation(sender: recordButton)
        recordButton.isSelected = !recordButton.isSelected
        isRecording = !isRecording
        animatePulseButton(recordButton)
        if recordButton.isSelected && isRecording{
            GoogleSpeechManager.startRecording()
            captionTitleLabel.text = "Now listening for sound to captions"
            recordButton.setImage(UIImage(named: "icons8-pause-100"), for: .normal)
            print("recording")
            startTimer()
        }else{
            GoogleSpeechManager.stopRecording()
            pauseTimer()
            captionTitleLabel.text = "Tap to record captions"
            recordButton.setImage(UIImage(named: "icons8-microphone-100"), for: .normal)
            print("stopped recording")
            endPulseSpringAnimation(sender: recordButton)
            self.recordButton.layer.removeAnimation(forKey: "pulse")
        }
//        let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.errorViewController) as! ErrorViewController
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
        
        
    }
}

extension HomeViewController: AudioControllerDelegate {
    
//    MARK: - Styles
    func styles(){
        roundCorners(button: recordButton)
        roundCorners(button: createNoteButton)
        recordButton.layer.shadowColor = Constants.Colors.CGgreen
        recordButton.layer.shadowRadius = 35
        recordButton.layer.shadowOpacity = 1
        recordButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        createNoteButton.layer.borderColor = Constants.Colors.CGgreen
        createNoteButton.layer.borderWidth = 1.0
        
    }
//    MARK: - animate button
    func animateButton(_ animateTo: UIView){
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [.repeat,.autoreverse,.curveLinear,.allowUserInteraction,], animations: {
            animateTo.transform = CGAffineTransform(scaleX: 0.96, y: 0.96)
        }, completion: nil)
    }
    func pulseSpringAnimation(sender: UIButton){
        let pulse = pulseAnimation(numberOfPulses: Float.infinity, radius: 150, position: sender.center)
        pulse.animationDuration = 1.0
        pulse.backgroundColor = #colorLiteral(red: 0.3183380067, green: 0.5116834044, blue: 0.5298893452, alpha: 1)
        self.view.layer.insertSublayer(pulse, below: sender.layer)
    }
    func endPulseSpringAnimation(sender: UIButton){
        let pulse = pulseAnimation(numberOfPulses: 0, radius: 0, position: sender.center)
        pulse.animationDuration = 0.0
        pulse.backgroundColor = #colorLiteral(red: 0.3183380067, green: 0.5116834044, blue: 0.5298893452, alpha: 1)
        pulse.removeAnimation(forKey: "pulse")
        pulse.removeFromSuperlayer()
        pulse.cancelPulseAnimation()
        pulse.removeAllAnimations()
        self.view.layer.insertSublayer(pulse, below: sender.layer)
    }
    
//    MARK: - read userDefaults
    func getUserDefaultsData(){
        // used to format name strings
        let nameFormatter = PersonNameComponentsFormatter()
        
        
        // read data from userDefaults
        let userData = userDefaultManager.userDefault.object(forKey: "user") as? [String:String]
        
        for data in userData ?? [:]{
            print("\(data)")
        }
        let name:String = userData?["username"] ?? ""
        let gender:String = userData?["gender"] ?? ""
        if let userName = nameFormatter.personNameComponents(from: name){
            nameFormatter.style = .short
            nameTextLabel.text =  "Hey, \(nameFormatter.string(from: userName)) 👋"
        }
        // checks gender type
        if gender == "Male"{
            avatarImage.image = UIImage(named: "icons8-man-medium-skin-tone-100")
        }else if gender == "Female"{
            avatarImage.image = UIImage(named: "icons8-woman-curly-hair-medium-skin-tone-100")
        }
    }
//    MARK:- Timer functions
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
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    func pauseTimer(){
        timer.invalidate()
    }
    func stopTimer(){
        timer.invalidate()
        (hours,minutes,seconds,fractions) = (0,0,0,0)
        hourLabel.text = "0\(hours):"
        minuteLabel.text = "0\(minutes):"
        secondLabel.text = "0\(seconds)."
        fractionLabel.text = "0\(fractions)"
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
//    MARK:- streaming recording
    func beginRecoding(){
        isRecording = !isRecording
        if isRecording{
            GoogleSpeechManager.startRecording()
        }else{
            GoogleSpeechManager.stopRecording()
        }
    }
//   audio delegate implementation
//   function is responsible to take the audio input and relay back the response in the text format
    func processSampleData(_ data: Data) -> Void {
        if let audio_data = audioData{
            audio_data.append(data)
        }
//        print("audio input started")

      // We recommend sending samples in 100ms chunks
      let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
        * Double(Constants.Audio.SAMPLE_RATE) /* samples/second */
        * 2 /* bytes/sample */);
        if let checkAudioData = audioData{
            if (checkAudioData.length > chunkSize) {
              SpeechRecognitionService.sharedInstance.streamAudioData(audioData,
                                                                      completion:
                { [weak self] (response, error) in
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let error = error {
                      strongSelf.spokenTextView.text = error.localizedDescription
                    } else if let response = response {
                        var finished = false
                        print(response)
                        for result in response.resultsArray! {
                            if let result = result as? StreamingRecognitionResult {
                                if result.isFinal {
                                    finished = true
      //                            display streaming text
                                    print("\(response.description)")
                                  strongSelf.spokenTextView.text = response.description
                                }
                            }
                        }
                      strongSelf.spokenTextView.text = response.description
                        if finished {
                            strongSelf.stopAudio(strongSelf)
                        }
                    }
              })
              self.audioData = NSMutableData()
            }
          }
        }
     
    func stopAudio(_ sender: NSObject) {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
      }
//    MARK:- grant microphone access
    func microphonePermissions(){
        switch AVAudioSession.sharedInstance().recordPermission{
        case AVAudioSession.RecordPermission.granted:
            print("Granted")
        case AVAudioSession.RecordPermission.denied:
            print("Denied")
        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
        @unknown default:
            fatalError()
        }
    }
}
