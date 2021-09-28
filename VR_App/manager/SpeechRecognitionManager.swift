//
//  SpeechRecognitionManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 28/09/2021.
//

import UIKit
import Speech

struct SpeechRecognitionManager{
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var task: SFSpeechRecognitionTask! = nil
    
    enum SpeechError:Error{
        case noAudioListener
        case localRecognition
        case busyRecognition
        case noAudioResponse
        
    }
    static var shared = SpeechRecognitionManager()
    
    private init(){
        
    }
    
    mutating func recordSpeech(completion: @escaping (Result<String,SpeechError>) -> Void){
        let node = audioEngine.inputNode
        //  Remove tap first.
        node.removeTap(onBus: 0)
        let recordingFormat = node.outputFormat(forBus: 0)
        //            let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [self] (buffer, _) in
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
        request.shouldReportPartialResults = true
        //        start recognizing
        task = speechRecognizer?.recognitionTask(with: request, resultHandler: { response, error in
            guard let response = response else {
                if error != nil {
                    print("\(error.debugDescription)")
                }else{
                    completion(.failure(.noAudioResponse))
                }
                
                return
            }
            //    gets transcription text
            let message = response.bestTranscription.formattedString
            completion(.success(message))
            print("message: \(message) ")
            
            
        })
    }
    
    mutating func stopSpeech(completion: @escaping (Result<Void,Error>) -> Void){
        if let audiotask = task{
            audiotask.finish()
            //                audiotask.cancel()
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
        completion(.success(()))
    }
}
