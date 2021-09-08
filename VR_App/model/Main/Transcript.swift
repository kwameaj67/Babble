//
//  Transcript.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 11/08/2021.
//

import Foundation
import UIKit
//
//{
//  "name": "1268386125834704889",
//  "metadata": {
//    "lastUpdateTime": "2016-08-31T00:16:32.169Z",
//    "@type": "type.googleapis.com/google.cloud.speech.v1.LongrunningRecognizeMetadata",
//    "startTime": "2016-08-31T00:16:29.539820Z",
//    "progressPercent": 100
//  }
//  "response": {
//    "@type": "type.googleapis.com/google.cloud.speech.v1.LongRunningRecognizeResponse",
//    "results": [{
//      "alternatives": [{
//        "confidence": 0.98267895,
//        "transcript": "how old is the Brooklyn Bridge"
//      }]}]
//  },
//  "done": True,
//}

struct TranscriptModel{
    var title: String
    var description:String
    var date:String
    
    static let transcriptData: [TranscriptModel] = [
        TranscriptModel(title: "Beats", description: "Album 150 130Bmp", date:"05/05/2021"),
        TranscriptModel(title: "Web application tools", description: "I would be a first billionaire", date:"05/05/2021"),
        TranscriptModel(title: "ASR technology", description: "Automated speech recognition is any technology that allows a computer to convert spoken language into typed text in real time", date:"05/05/2021"),
        TranscriptModel(title: "Voice recognition App", description: "Wise Quotes Before you perish, it's significant for your hereafter to leave behind or to give to the world your wisdom, experience, and knowledge, for humanity thrives on the past, present and to forecast the future.", date:"05/05/2021"),
        TranscriptModel(title: "Personal timetable", description: "This contains the semester timetable according to my courses", date:"05/05/2021"),
        TranscriptModel(title: "📌IOS Articles", description: "ios Development https://sarunw.com/posts/", date:"05/05/2021"),
    ]
    
}
struct ResponseData: Decodable{
    var data:Response
    var done: Bool
    var metadata:MetaData
}
struct MetaData:Decodable{
    var lastUpdateTime:Date
    var progressPercent: Int
}
struct Response: Decodable{
    var response:Results
}
struct Results:Decodable {
    var results:[Alternatives]  // returns array of alternatives dictionaries
}
struct Alternatives:Decodable{
    var alternatives:[Transcript]  // returns array of transcript dictionaries
}
struct Transcript:Decodable {
    var confidence: Float?
    var transcript:String?
}


// choose where you want captions - select situations where you'd like to better understand what people say
// e.g conference calls, face-to-face, group hangout, online videos, student life, stores and shops, place of worship, events

// show alert, Continue without saving the transcript? Continue & Save

// https://cloud.google.com/speech-to-text/docs/samples/speech-transcribe-streaming-mic#speech_transcribe_streaming_mic-nodejs
