//
//  SwiperCollectionViewCell.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 09/08/2021.
//

import UIKit

class SwiperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var SwipeImage: UIImageView!
    @IBOutlet weak var SwipeTitle: UILabel!
    @IBOutlet weak var SwipeDescription: UILabel!
    
    
    func configureSwiper(item:Swipe){
        SwipeImage.image = item.image
        SwipeTitle.text = item.title
        SwipeDescription.text = item.description
        
    }
}
