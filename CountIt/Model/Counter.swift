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
    @objc dynamic var daysTillDate: Int = 0
    
    func countDays() -> Int {
        if let chosenDate = tillDate {
            var daysLeft = 0.0
            let currentDate: Date = Date.init()
            daysLeft = currentDate.timeIntervalSince(chosenDate)
            return Int(daysLeft)
        } else { return -1 }
    }
}
