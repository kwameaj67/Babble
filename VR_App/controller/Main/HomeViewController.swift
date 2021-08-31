//
//  HomeViewController.swift
//  VR_App
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import UIKit
import Firebase
import AVFoundation
import googleapis
import Speech

class HomeViewController: UIViewController{
// MARK:- local properties
    var isRecording: Bool = false
    var audioData: NSMutableData!
   
    var captionsTitles:[String] = ["Record your speech","Tap to start captions","Transcribe all captions with a tap"]
//  speech local properties
    var audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask! = nil
    
//    MARK:- outlets
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var createNoteButton: UIButton!
    @IBOutlet weak var captionTitleLabel: UILabel!
   
    
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
        getUserDefaultsData()
        let user = Auth.auth().currentUser?.email
        print(user ?? "user no found")
//        AudioController.sharedInstance.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
//        cancelSpeechRecognition()
    }
    
    
  
    @IBAction func onTapCreateNote(_ sender: Any) {
        let noteVC = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.noteViewController) as! NoteViewController
        noteVC.modalPresentationStyle = .fullScreen
        present(noteVC, animated: true, completion: nil)
       
    }
    @IBAction func onTapRecordBustton(_ sender: UIButton) {
        
        pulseSpringAnimation(sender: recordButton)
        recordButton.isSelected = !recordButton.isSelected
        animatePulseButton(recordButton)
        if recordButton.isSelected{
            captionTitleLabel.text = "Now listening for sound to captions"
            recordButton.setImage(UIImage(named: "icons8-pause-100"), for: .normal)
            print("recording")
            startSpeechRecognition()
        }else{
            cancelSpeechRecognition()
            captionTitleLabel.text = "Tap to record captions"
            recordButton.setImage(UIImage(named: "icons8-microphone-100"), for: .normal)
            print("stopped recording")
            endPulseSpringAnimation(sender: recordButton)
            self.recordButton.layer.removeAnimation(forKey: "pulse")
        }
    }
    func showRecordingVC(){
                let vc = storyboard?.instantiateViewController(identifier: Constants.StoryboardID.recordingViewController) as! RecordingViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
             
    }
}

extension HomeViewController {
//  MARK: - alerts
    func showAlert(message:String){
        let alert = UIAlertController(title: "Oops!", message:message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
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

//    MARK:- streaming recording
    func beginRecoding(){
        isRecording = !isRecording
        if isRecording{
            GoogleSpeechManager.startRecording()
        }else{
            GoogleSpeechManager.stopRecording()
        }
    }
//   audio delegate implementation,function is responsible to take the audio input and relay back the response in the text format
//    func processSampleData(_ data: Data) -> Void {
////        audioData?.append(data)
//        if let audio_data = audioData{
//            audio_data.append(data)
//        }
//      // We recommend sending samples in 100ms chunks
//      let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
//        * Double(Constants.Audio.SAMPLE_RATE) /* samples/second */
//        * 2 /* bytes/sample */);
//        if let checkAudioData = audioData{
//        if (checkAudioData.length > chunkSize) {
//            print("audio input started")
//              SpeechRecognitionService.sharedInstance.streamAudioData(audioData, completion:
//                { [weak self] (response, error) in
//                    guard let strongSelf = self else {
//                        return
//                    }
//
//                    if let error = error {
////                      strongSelf.text = error.localizedDescription
//                    } else if let response = response {
//                        var finished = false
//                        print(response)
//                        for result in response.resultsArray! {
//                            if let result = result as? StreamingRecognitionResult {
//                                if result.isFinal {
//                                    finished = true
//      //                            display streaming text
//                                    print("\(response.description)")
////                                  strongSelf.text = response.description
//                                }
//                            }
//                        }
////                      strongSelf.text = response.description
//                        if finished {
//                            strongSelf.stopAudio(strongSelf)
//                        }
//                    }
//              })
//              self.audioData = NSMutableData()
//            }
//          }
//        }
//
    func stopAudio(_ sender: NSObject) {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
      }
//    MARK:- grant microphone access
    func microphonePermissions(){
        SFSpeechRecognizer.requestAuthorization { authState in
            DispatchQueue.main.async {
                self.recordButton.isEnabled = false
            }
            /*
                       The callback may not be called on the main thread. Add an
                       operation to the main queue to update the record button's state.
                   */
            OperationQueue.main.addOperation {
                switch authState{
                case .notDetermined:
                    print("NOT KNOWN")
                case .denied:
                    print("DENIED")
                    self.showAlert(message: "User denied Speech permission")
                case .restricted:
                    print("RESTRICTED")
                    self.showAlert(message: "User has been restricted for using Speech recognition")
                case .authorized:
                    print("ACCEPTED")
                    self.recordButton.isEnabled = true
                @unknown default:
                    fatalError()
                }
            }
        }
    }
    
//    MARK: - start speech recognition
    func startSpeechRecognition(){
//        self.recordButton.isEnabled = false
        let node = audioEngine.inputNode
        //Remove tap first.
        node.removeTap(onBus: 0)
        // Configure the microphone input.
        let recordingFormat = node.outputFormat(forBus: 0)
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
                }
                else{
                    self.showAlert(message: "Something went wrong in getting audio response!")
                }
                return
            }
//            gets transcription
            let message = response.bestTranscription.formattedString
            print("got messages")
            if message != "" {
                self.showRecordingVC()
                self.recordButton.setImage(UIImage(named: "icons8-microphone-100"), for: .normal)
            }

            
        })
    }
//    MARK: - cancel speech recognition
    func cancelSpeechRecognition(){
        task.finish()
        task.cancel()
        task = nil
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
    }
}
