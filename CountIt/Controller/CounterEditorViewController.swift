//
//  counterEditorViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 09/10/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class CounterEditorViewController: UIViewController {
    
    @IBOutlet weak var counterTitleLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    let realm = try! Realm()
    var selectedCounter: Counter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loadData()
    }
    
    func loadData() {
        if let name = selectedCounter?.name {
            counterTitleLabel.text = name
        }
        
        if let daysLeft = selectedCounter?.daysLeft {
            daysLeftLabel.text = String(daysLeft)
        }
    }
}
