//
//  ProfileTableViewCell.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 03/10/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    
   
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descLbl: UILabel!
    
    
    
    func setupProfileDetails(with item: ActorDetails){
        titleLbl.text = item.title
        descLbl.text = item.desc ?? "No data"
    }
}
