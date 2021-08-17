//
//  UserDefaults+Extension.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 17/08/2021.
//

import Foundation

struct userDefaults {
    
    static let defaults = UserDefaults.standard
    static let key = "userData"
    static var userData: [String:Any] = [
        "email":String.self,
        "username":String.self,
        "gender":String.self,
        "identity":String.self,
        "uuid":String.self
    ]
    
    static var createStoreUserData: Void = defaults.setValue(userData, forKey: key)
    
    static var getStoreUserData = defaults.dictionary(forKey: key)
}
