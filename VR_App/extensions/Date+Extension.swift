//
//  Date+Extension.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 10/09/2021.
//

import Foundation

extension Date{
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self){
            formatter.dateFormat = "h:mm:a"
        }else{
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: self)
    }
}
