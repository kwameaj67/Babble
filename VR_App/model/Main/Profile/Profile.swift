//
//  Profile.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 13/09/2021.
//

import Foundation
import UIKit


struct Profile {
    var profileOptions: ProfileOptions = .settings
    
    var profileImage: UIImage? {
        switch profileOptions {
        case .settings:
            return  UIImage(systemName: "gearshape")
        case .help:
            return UIImage(systemName: "info.circle")
        case .support:
            return UIImage(systemName: "text.bubble")
        case .invite:
            return UIImage(systemName: "square.and.arrow.up")
        }
    }
}
