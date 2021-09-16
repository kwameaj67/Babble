//
//  userDefault.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 20/08/2021.
//

import Foundation
import UIKit

struct userDefaultManager {
    static let userDefault = UserDefaults.standard
    static let getData = userDefault.object(forKey: "user") as? [String:String]
    static let removeData: Void = userDefault.removeObject(forKey: "user")
    
    
    struct userDetails{
        static let name = getData?["username"] ?? ""
        static let gender = getData?["gender"] ?? ""
        static let uuid = getData?["uuid"] ?? ""
        static let email = getData?["email"] ?? ""
        static let identity = getData?["identity"] ?? ""
    }
    
}
