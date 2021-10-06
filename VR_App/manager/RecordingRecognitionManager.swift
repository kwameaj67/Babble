//
//  RecordingRecognitionManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 05/10/2021.
//


import UIKit
import Speech

struct RecordingRecognitionManager{
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var request =  SFSpeechAudioBufferRecognitionRequest() // recreates recognitionRequest object.
    
    private var task: SFSpeechRecognitionTask?
    
    enum SpeechError:Error{
        case noAudioListener
        case localRecognition
        case busyRecognition
        case noAudioResponse
        
    }
    static var shared = RecordingRecognitionManager()
    
    private init(){
        
    }
    
    mutating func recordSpeech(completion: @escaping (Result<String,SpeechError>) -> Void) throws{
//        // Cancel the previous task if it's running.
        task?.cancel()
        self.task = nil
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let node = audioEngine.inputNode
        //  Remove tap first.
        node.removeTap(onBus: 0)
        
        request.shouldReportPartialResults = true
        //        start recognizing
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {[ self](buffer , _) in
            self.request.append(buffer)
        }
        //        prepare audio engine
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch _ {
            completion(.failure(.noAudioListener))
        }
        
        guard let myRecognition = SFSpeechRecognizer() else {
            completion(.failure(.localRecognition))
            return
        }
    
        if !myRecognition.isAvailable{
            completion(.failure(.busyRecognition))
        }
       
       
        task = speechRecognizer?.recognitionTask(with: request, resultHandler: { response, error in
            print("starting recording")
            if response != nil { // check to see if result is empty (i.e. no speech found)
                if let result = response {
                    let bestString = result.bestTranscription.formattedString
                    print(bestString)
                    completion(.success(bestString))
                    
                } else if let error = error {
                    
                    print("error:\(error.localizedDescription)")
                }
            }else{
                completion(.failure(.noAudioResponse))
            }
        })
    }
    
    mutating func stopSpeech(completion: @escaping (Result<Void,Error>) -> Void){
        //        stop audio
        if audioEngine.isRunning{
            request.endAudio()
            audioEngine.stop()
        }
        //        stop recognition
        if let audiotask = task{
            audiotask.finish()
        }
        task = nil
        
        
        let input_Node = audioEngine.inputNode
        if (input_Node.inputFormat(forBus: 0).channelCount == 0){
            NSLog("Not enough available inputs!")
        }
        input_Node.removeTap(onBus: 0)
        print("stopped recording")
        completion(.success(()))
    }
}

