//
//  TableViewCounterCell.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import UIKit

class TableViewCounterCell: UITableViewCell {
    
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterDays: UILabel!
    
    func setCell(title: String, daysLeft: String) {
        setTitleLabel(withTitle: title)
        setDateLabel(withDate: daysLeft)
    }
    
    func setTitleLabel(withTitle title: String) {
        counterTitle.text = title
    }
    
    func setDateLabel(withDate date: String) {
        counterDays.text = date
    }

}
