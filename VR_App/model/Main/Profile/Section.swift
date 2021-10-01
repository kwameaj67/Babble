//
//  Section.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 30/09/2021.
//

import Foundation

struct Section {
    var sectionName: String
    var sectionItems: [Profile]
    
    static let sectionArray = [
        Section(sectionName: "General", sectionItems: ProfileItems.section1),
        Section(sectionName: "About", sectionItems: ProfileItems.section2),
        Section(sectionName: "Help", sectionItems: ProfileItems.section3)
    ]
    
}


