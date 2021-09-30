//
//  constants.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import Foundation
import UIKit

struct Constants {
    //        Main App Segue IDs
    struct Segue {
        static let showOnboarding = "showOnboarding"
        static let showWelcome = "showWelcome"
        static let showSignin = "showSignin"
        static let showSignup = "showSignup"
        static let showGender = "showGender"
        static let showIdentity = "showIdentity"
    
    }
    //      Main App Storyborad file names
    struct StoryboardName{
        static let onboardingStoryboard = "Main"
        static let authStoryboard = "Auth"
        static let tabBarStoryboard = "TabBar"
    }
    struct StoryboardID{
        static let onboardingController = "onboardingController"
        static let authInitController = "authInitController"
        static let welcomeController = "welcomeController"
        static let signupController = "signupController"
        static let signinController = "signinController"
        static let genderController = "genderController"
        static let identityController = "identityController"
        static let forgotPasswordController = "forgotPasswordController"
        
        
        
//        Main App IDs
        static let tabBarController = "mainTabController"
        static let errorViewController = "errorController"
        static let noteViewController = "noteViewController"
        static let recordingViewController = "recordingViewController"
        static let detailedTranscriptViewController = "detailedTranscriptsViewController"
        static let profileViewController = "profileViewController"
    }
    struct Colors {
        static let green = UIColor(red: 0.26, green: 0.52, blue: 0.54, alpha: 1.00)
        static let red = UIColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 1.00)
        static let white = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
        
//        CGColors
        static let CGgreen = CGColor(red: 0.26, green: 0.52, blue: 0.54, alpha: 1.00)
        static let CGred = CGColor(red: 0.72, green: 0.00, blue: 0.00, alpha: 1.00)
        static let CGwhite = CGColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
    }
    struct DBCollection {
        static let users = "users"
        static let transcriptions = "transcriptions"
    }
    struct Audio {
        static let SAMPLE_RATE = 44100.0
    }
    struct TableViewCell{
        static let profile = "profile"
    }
}
