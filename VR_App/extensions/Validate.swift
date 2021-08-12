//
//  Validate.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 12/08/2021.
//

import Foundation

extension String{
    func isValidEmail() -> Bool {
        let inputRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let inputPred = NSPredicate(format: "SELF MATCHES %@",inputRegEx)
        return inputPred.evaluate(with: self)
    }
    func isValidPassword() -> Bool {
        let inputRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,50}$"  // have small, capital characters & numbers from 6-15
        let inputPred = NSPredicate(format: "SELF MATCHES %@",inputRegEx)
        return inputPred.evaluate(with: self)
    }
}
