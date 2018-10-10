//
//  TableViewCounterCell.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//
import Foundation
import UIKit

class TableViewCounterCell: UITableViewCell {
    
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterDays: UILabel!
    @IBOutlet weak var counterDescriptionLabel: UILabel!
    
    func setCell(withTitle title: String, withDays daysLeft: String, withDescription description:String) {
        setTitleLabel(withTitle: title)
        setDateLabel(withDate: daysLeft)
        setDescriptionLabel(withDescritpion: description)
    }
    
    func setTitleLabel(withTitle title: String) {
        counterTitle.text = title
    }
    
    func setDateLabel(withDate date: String) {
        counterDays.text = date
    }
    
    func setDescriptionLabel(withDescritpion description: String) {
        counterDescriptionLabel.text = description
    }

}
