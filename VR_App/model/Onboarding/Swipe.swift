//
//  Swipe.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 09/08/2021.
//

import Foundation
import UIKit



struct Swipe{
    var image:UIImage
    var title:String
    var description:String
    
    
    
    static let swipeData:[Swipe] = [
        Swipe(image: UIImage(named: "Voice control-bro")!, title: "Why use Babble?", description: "Babble is a speech recognition software which is extremely valuable to anyone who needs to generate a lot of written content without a lot of manual typing"),
        Swipe(image: UIImage(named: "Voice interface-pana")!, title: "Communicate efficiently", description: "It is also useful for people with disabilities that make it difficult for them to use a keyboard."),
        Swipe(image: UIImage(named: "Voice control-rafiki")!, title: "Live captioning solution", description: "It takes audio content and transcribes it into written words in a word processor or other display destination. "),
        
    ]
}
