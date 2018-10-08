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
    
    let realm = try! Realm()
    var counters: Results<Counter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counters = realm.objects(Counter.self)
    }
    
    @IBAction func dateButtonPressed(_ sender: Any) {
        do {
            try realm.write {
                let newCounter = Counter()
                newCounter.name = counterTitleTextField.text ?? "NotSet"
                newCounter.tillDate = counterDatePicker.date
                realm.add(newCounter)
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            }
        } catch {
            print("Error")
        }
    }
}
