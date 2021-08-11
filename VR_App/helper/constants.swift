//
//  constants.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 04/08/2021.
//

import Foundation


struct Constants {
    struct Segue {
        static let showOnboarding = "showOnboarding"
        static let showWelcome = "showWelcome"
        static let showSignin = "showSignin"
        static let showSignup = "showSignup"
        static let showGender = "showGender"
        static let showIdentity = "showIdentity"
        
//        Main App Segue IDs
    }
    
    struct StoryboardName{
        static let onboardingStoryboard = "Main"
        static let authStoryboard = "Auth"
        
//      Main App Storyborad file names
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
        
        
//        Main App IDs
        static let tabBarController = "mainTabController"
    }
}
