//
//  CreateCounterTableViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 02/06/2019.
//  Copyright © 2019 Mattia Righetti. All rights reserved.
//

import RealmSwift
import UIKit

class CreateCounterTableViewController: UITableViewController {
    @IBOutlet var counterDatePicker: UIDatePicker!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var excludeLastSwitch: UISwitch!

    let realm = try! Realm()
    var counters: Results<Counter>?
    var isInEditMode: Bool = false
    var counter: Counter? {
        didSet {
            isInEditMode = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        if isInEditMode {
            setupViewControllerWithData(ofCounter: counter!)
        }
    }

    /**
     Prepares viewController main view functionalities
     */
    func setupView() {
        counterDatePicker.minimumDate = Date()
        titleTextField.autocapitalizationType = .words
        descriptionTextField.autocapitalizationType = .sentences
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(handleSave))
    }

    /**
     Initialises viewController with **Counter** data
     */
    func setupViewControllerWithData(ofCounter counter: Counter) {
        counterDatePicker.date = counter.tillDate!
        titleTextField.text = counter.name
        descriptionTextField.text = counter.counterDescription
        excludeLastSwitch.isOn = counter.excludeLast
    }

    /**

     */
    @objc func handleSave() {
        if !titleTextField.text!.isEmpty {
            do {
                try realm.write {
                    if !isInEditMode {
                        let newCounter = Counter()
                        newCounter.name = titleTextField.text ?? "Undefined"
                        newCounter.tillDate = counterDatePicker?.date
                        newCounter.excludeLast = excludeLastSwitch.isOn
                        newCounter.colorHex = UIColor(randomColorIn: mainColors)?.hexValue()

                        if let descriptionTF = descriptionTextField.text {
                            newCounter.counterDescription = descriptionTF
                        }

                        realm.add(newCounter)
                    } else {
                        counter!.name = titleTextField.text ?? "Undefined"
                        counter!.tillDate = counterDatePicker?.date
                        counter!.excludeLast = excludeLastSwitch.isOn
                        counter!.colorHex = UIColor(randomColorIn: mainColors)?.hexValue()

                        if let descriptionTF = descriptionTextField.text {
                            counter!.counterDescription = descriptionTF
                        }
                    }

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

            }))
            present(alert, animated: true, completion: nil)
        }
    }

    // MARKUP: - TABLE VIEW CONTROLLER METHODS

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 4
    }
}
