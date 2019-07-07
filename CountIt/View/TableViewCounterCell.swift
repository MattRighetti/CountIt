//
import ChameleonFramework
//  TableViewCounterCell.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//
import Foundation
import UIKit

let mainColors = [UIColor.flatYellow, UIColor.flatRed, UIColor.flatMint, UIColor.flatOrange, UIColor.flatBlue, UIColor.flatBrown, UIColor.flatSkyBlueDark, UIColor.flatNavyBlue, UIColor.flatLimeDark, UIColor.flatSkyBlueDark, UIColor.flatWatermelon]

class TableViewCounterCell: UITableViewCell {
    @IBOutlet var counterTitle: UILabel!
    @IBOutlet var counterDays: UILabel!
    @IBOutlet var counterDescriptionLabel: UILabel!
    @IBOutlet var missingLabel: UILabel!
    @IBOutlet var counterView: UIView!
    
    func setCell(withTitle title: String, withDays daysLeft: String, withDescription description: String, withColor color: UIColor) {
        selectionStyle = .none
        roundCounterView()
        applyGradientColor(withColor: color)
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
        counterView.layer.cornerRadius = 30
    }
    
    func applyGradientColor(withColor color: UIColor) {
        let randomColor = color
        let lighterRandomColor = randomColor.lighten(byPercentage: 25)!
        counterDays.textColor = .white
        counterView.layer.backgroundColor = UIColor(gradientStyle: UIGradientStyle.diagonal, withFrame: counterView.frame, andColors: [lighterRandomColor, randomColor]).cgColor
    }
}
