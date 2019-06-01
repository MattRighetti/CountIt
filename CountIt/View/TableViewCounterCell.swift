//
//  TableViewCounterCell.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//
import Foundation
import UIKit
import ChameleonFramework

class TableViewCounterCell: UITableViewCell {
    
    @IBOutlet weak var counterTitle: UILabel!
    @IBOutlet weak var counterDays: UILabel!
    @IBOutlet weak var counterDescriptionLabel: UILabel!
    @IBOutlet weak var missingLabel: UILabel!
    @IBOutlet weak var counterView: UIView!
    
    func setCell(withTitle title: String, withDays daysLeft: String, withDescription description:String) {
        roundCounterView()
        randomGradientColorView()
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
    
    func makeTextWhite() {
        counterTitle.textColor = .white
        counterDays.textColor = .white
        counterDescriptionLabel.textColor = .white
        missingLabel.textColor = .white
    }
    
    func roundCounterView() {
        counterView.layer.cornerRadius = 25
    }
    
    func randomGradientColorView() {
        let randomColor = UIColor(randomFlatColorOf: .dark)
        let lighterRandomColor = randomColor.lighten(byPercentage: 10)!
        counterDays.textColor = .white
        counterView.layer.backgroundColor = UIColor(gradientStyle:UIGradientStyle.diagonal, withFrame:counterView.frame, andColors:[lighterRandomColor, randomColor]).cgColor
    }

}
