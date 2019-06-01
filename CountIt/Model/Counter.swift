//
//  Counter.swift
//  CountIt
//
//  Created by Mattia Righetti on 15/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import Foundation
import RealmSwift

class Counter: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var tillDate: Date?
    @objc dynamic var excludeLast: Bool = false
    @objc dynamic var daysLeft = 0
    @objc dynamic var counterDescription: String = ""
    @objc dynamic var colorHex: String!
    
    func countDays() {
        if let chosenDate = tillDate {
            var calendar = Calendar.current.dateComponents([.day], from: Date(), to: chosenDate)
            daysLeft = calendar.day ?? -1
            if (excludeLast == true && daysLeft > 1) {
                daysLeft -= 0
            } else {
                daysLeft += 1
            }
        }
    }
}
