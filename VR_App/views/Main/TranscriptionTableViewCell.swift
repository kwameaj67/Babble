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
    @IBOutlet var iconContainer: UIView!
    
    func setupTranscriptionCell(item: Transcriptions){
        titleLabel.text = item.title
        descriptionLabel.text = item.text
        let date = Date()
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(date){
            formatter.dateFormat = "h:mm:a"
        }else{
            formatter.dateFormat = "MMM d, yyyy"
        }
//        print(item.date!)
        let transcriptDate = formatter.string(from: item.date ?? date)
        dateLabel.text = transcriptDate
        iconContainer.layer.cornerRadius = iconContainer.layer.frame.height/2.2
    }
}

