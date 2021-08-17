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
func textInputRoundCorners(view:UIView){
    view.layer.cornerRadius = view.layer.frame.height / 2
}
 func animatePulseButton(_ animateTo:UIView){
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1.5, options: .curveEaseIn) {
        animateTo.transform = CGAffineTransform(scaleX: 0.93, y:0.93)
    } completion: { (_) in
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            animateTo.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:nil)
//        print("Animation complete")
    }
}
func inputConfig(input:UITextField){
    input.autocorrectionType = .no
    input.autocapitalizationType = .none
}
// CGColor(red: 0.26, green: 0.52, blue: 0.54, alpha: 1.00) 


