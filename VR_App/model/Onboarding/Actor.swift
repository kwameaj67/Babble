//
//  Actor.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 17/08/2021.
//

import Foundation

enum ActorEnum: String, CaseIterable{
    case name = "Full name"
    case email = "Email Address"
    case gender = "Gender"
    case hearingProfile = "Hearing Profile"
}
struct Actor {
    var email:String?
    var gender:String?
    var identity:String?
    var username:String?
    var uid:String?
    

}

struct ActorDetails {
    var title:String
    var desc:String?
}
