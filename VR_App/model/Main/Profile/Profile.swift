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
        case .viewProfile:
            return UIImage(systemName: "person.crop.circle")
        case .settings:
            return  UIImage(systemName: "gearshape")
        case .help:
            return UIImage(systemName: "info.circle")
        case .support:
            return UIImage(systemName: "text.bubble")
        case .invite:
            return UIImage(systemName: "square.and.arrow.up")
        case .terms:
            return UIImage(systemName: "doc.text.below.ecg")
        case .privacy:
            return UIImage(systemName: "lock.circle")
        case .faq:
            return UIImage(systemName: "questionmark.circle")
        case .report:
            return UIImage(systemName: "arrow.up.doc")
        case .contact:
            return UIImage(systemName: "pencil.circle")
            
        }
    }
}

