//
//  helper.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import Foundation
import UIKit



func delay(duration: Double, completion: @escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
}


func roundCorners(button:UIButton){
    button.layer.cornerRadius = button.layer.frame.height / 2
}
