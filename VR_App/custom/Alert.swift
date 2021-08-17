//
//  Alert.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 16/08/2021.
//

import Foundation
import UIKit



class AlertController:UIAlertController{
    
    func showAlert(title:String,msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
    }
}
