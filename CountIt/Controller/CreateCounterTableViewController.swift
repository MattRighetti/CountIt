//
//  CreateCounterTableViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 02/06/2019.
//  Copyright © 2019 Mattia Righetti. All rights reserved.
//

import UIKit
import RealmSwift

class CreateCounterTableViewController: UITableViewController {
    
    @IBOutlet weak var counterDatePicker: UIDatePicker!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var excludeLastSwitch: UISwitch!
    
    let realm = try! Realm()
    var counters: Results<Counter>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        counterDatePicker.minimumDate = Date()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        titleTextField.autocapitalizationType = .words
        descriptionTextField.autocapitalizationType = .sentences
    }
    
    @objc func handleSave() {
        if !titleTextField.text!.isEmpty {
            do {
                try realm.write {
                    let newCounter = Counter()
                    newCounter.name = titleTextField.text ?? "Undefined"
                    newCounter.tillDate = counterDatePicker?.date
                    newCounter.excludeLast = excludeLastSwitch.isOn
                    newCounter.colorHex = UIColor(randomColorIn: mainColors)?.hexValue()
                    
                    if let descriptionTF = descriptionTextField.text {
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
        } else {
            let alert = UIAlertController(title: "Empty Fields", message: "Title and Date fields can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARKUP: - TABLE VIEW CONTROLLER METHODS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

}
