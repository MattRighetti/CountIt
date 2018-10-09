//
//  CreateCounterViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 21/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import UIKit
import RealmSwift

class CreateCounterViewController: UIViewController {

    @IBOutlet weak var counterTitleTextField: UITextField!
    @IBOutlet weak var counterDatePicker: UIDatePicker!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var excludeLastSwitch: UISwitch!
    
    let realm = try! Realm()
    var counters: Results<Counter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addButton.layer.cornerRadius = 8
        counters = realm.objects(Counter.self)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        do {
            try realm.write {
                let newCounter = Counter()
                newCounter.name = counterTitleTextField.text ?? "NotSet"
                newCounter.tillDate = counterDatePicker.date
                newCounter.excludeLast = excludeLastSwitch.isOn
                realm.add(newCounter)
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }
        } catch {
            print(error)
        }
    }
}
