//
//  TranscriptionTableViewCell.swift
//  VR_App
//
//  Created by Kwame Agyenim - Boateng on 08/09/2021.
//

import UIKit

class TranscriptionTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    func setupTranscriptionCell(item: TranscriptModel){
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "d/MM/yyyy"
//        let transcriptionDate = formatter.string(from: item.date)
        dateLabel.text = "\(item.date) ."
        
    }
}
