//
//  ProfileItems.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 13/09/2021.
//

import Foundation



struct ProfileItems{
    
    static let section1: [Profile] = [
        Profile(profileOptions: .viewProfile),
        Profile(profileOptions: .settings),
        Profile(profileOptions: .help),
        Profile(profileOptions: .support),
        Profile(profileOptions: .invite),
    ]
    
    static let section2: [Profile] = [
        Profile(profileOptions: .terms),
        Profile(profileOptions: .privacy),
        Profile(profileOptions: .report),
    ]
    
    static let section3: [Profile] = [
        Profile(profileOptions: .faq),
        Profile(profileOptions: .contact),
    ]
    
    
   
}
