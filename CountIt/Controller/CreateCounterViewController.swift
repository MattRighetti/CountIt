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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var counterDescriptionTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var excludeLastSwitch: UISwitch!
    
    private var datePicker: UIDatePicker?
    
    let realm = try! Realm()
    var counters: Results<Counter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addButton.layer.cornerRadius = 8
        counters = realm.objects(Counter.self)
        
        datePicker = UIDatePicker()
        datePicker?.backgroundColor = UIColor.white
        datePicker?.datePickerMode = .date
        datePicker?.minimumDate = Date.init()
        datePicker?.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dateTextField.inputView = datePicker
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let date = datePicker?.date {
            dateTextField.text = dateFormatter.string(from: date)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if !counterTitleTextField.text!.isEmpty {
            do {
                try realm.write {
                    let newCounter = Counter()
                    newCounter.name = counterTitleTextField.text ?? "Undefined"
                    newCounter.tillDate = datePicker?.date
                    newCounter.excludeLast = excludeLastSwitch.isOn
                    if let descriptionTF = counterDescriptionTextField.text {
                        newCounter.counterDescription = descriptionTF
                    }
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
}
