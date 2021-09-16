//
//  ProfileTableViewCell.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 13/09/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    
    
    func setupProfile(with item:Profile){
        iconImage.image = item.profileImage
        title.text = item.profileOptions.rawValue
    }
}
