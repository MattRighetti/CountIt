//
//  SlideInDatePicker.swift
//  CountIt
//
//  Created by Mattia Righetti on 11/10/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import UIKit

class SlideInDatePicker: UIDatePicker {
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.datePickerMode = .date
        self.minimumDate = Date.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
