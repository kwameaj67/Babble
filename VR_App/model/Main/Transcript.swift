//
//  Transcript.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 11/08/2021.
//

import Foundation
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


struct Data: Decodable{
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

// screens - Settings, Transcribes, Home
