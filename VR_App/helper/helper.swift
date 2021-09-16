//
//  helper.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import Foundation
import UIKit

// MARK: - delay
func delay(duration: Double, completion: @escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
}

// MARK:- rounded corners
func roundCorners(button:UIButton){
    button.layer.cornerRadius = button.layer.frame.height / 2
}
func textInputRoundCorners(view:UIView){
    view.layer.cornerRadius = view.layer.frame.height / 2
}
// MARK:- pulse button animation
 func animatePulseButton(_ animateTo:UIView){
    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
        animateTo.transform = CGAffineTransform(scaleX: 0.93, y:0.93)
    } completion: { (_) in
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            animateTo.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:nil)
    }
}
// MARK: - textFields configs
func inputConfig(input:UITextField){
    input.autocorrectionType = .no
    input.autocapitalizationType = .none
}

// MARK: -  referencing the managed object context
 let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

// MARK: - get current date
func getDate() -> Date{
    let date = Date()
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    if Calendar.current.isDateInToday(date){
        formatter.dateFormat = "h:mm:a"
    }else{
        formatter.dateFormat = "MMM d, yyyy"
    }
  
    return date
}

