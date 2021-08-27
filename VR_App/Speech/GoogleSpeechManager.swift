//
//  GoogleSpeechManager.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 27/08/2021.
//

import UIKit

class GoogleSpeechManager: NSObject {
    //    start speech service

    class func startRecording(){
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: Int(Constants.Audio.SAMPLE_RATE))
        SpeechRecognitionService.sharedInstance.sampleRate = Int(Constants.Audio.SAMPLE_RATE)
        _ = AudioController.sharedInstance.start()
        print("recording")
    }
    
    
    //    stop speech service
    class func stopRecording(){
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
        print("stop recording")
    }
}
