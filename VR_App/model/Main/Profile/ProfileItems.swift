//
//  ProfileItems.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 13/09/2021.
//

import Foundation

struct ProfileItems{
    
    let items: [Profile] = [
        Profile(profileOptions: .settings),
        Profile(profileOptions: .help),
        Profile(profileOptions: .support),
        Profile(profileOptions: .invite),
    ]
}
