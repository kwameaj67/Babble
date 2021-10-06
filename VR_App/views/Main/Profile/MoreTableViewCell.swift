//
//  ProfileTableViewCell.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 13/09/2021.
//

import UIKit

class MoreTableViewCell: UITableViewCell {

    
    @IBOutlet var icon: UIImageView!
    @IBOutlet var title: UILabel!
    

    func setupProfile(with item:Profile){
        icon.image = item.profileImage
        title.text = item.profileOptions.rawValue
    }
}
