//
//  DateLauncher.swift
//  CountIt
//
//  Created by Mattia Righetti on 10/10/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import Foundation
import UIKit

class DateLauncher: NSObject {
    
    let blackView = UIView()
    let datePicker = UIDatePicker(frame: .zero)
    
    func showDatePicker() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
            window.addSubview(blackView)
            
            let datePickerHeight: CGFloat = 400
            let datePickerY = window.frame.height - datePickerHeight
            window.addSubview(datePicker)
            datePicker.backgroundColor = UIColor.white
            datePicker.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 400)
            datePicker.datePickerMode = .date
            blackView.frame = window.frame
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            blackView.alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.blackView.alpha = 1
                self.datePicker.frame = CGRect(x: 0, y: datePickerY, width: window.frame.width, height: 400)
            }
        }
    }
    
    @objc func handleDismiss() {
        print(datePicker.date.description(with: Locale.current))
        UIView.animate(withDuration: 0.3) {
            if let window = UIApplication.shared.keyWindow {
                self.datePicker.frame = CGRect(x: 0, y: window.frame.height, width: self.datePicker.frame.width, height: self.datePicker.frame.height)
            }
            
            self.blackView.alpha = 0
        }
    }
    
    override init() {
        super.init()
        
    }
    
}
