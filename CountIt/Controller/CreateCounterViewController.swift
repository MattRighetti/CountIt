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
    
    private var datePicker: SlideInDatePicker!
    
    let realm = try! Realm()
    var counters: Results<Counter>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTextFields()
        setupKetboardObservers()
        setupSlideInDatePicker()
        roundButton()
        
        counters = realm.objects(Counter.self)
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        if let date = datePicker?.date {
            dateTextField.text = dateFormatter.string(from: date)
        }
    }
    
    func setupSlideInDatePicker() {
        datePicker = SlideInDatePicker()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        dateTextField.inputView = datePicker
    }
    
    func setupTextFields() {
        counterTitleTextField.autocorrectionType = .no
        counterTitleTextField.autocapitalizationType = .words
        dateTextField.autocorrectionType = .no
        counterDescriptionTextField.autocorrectionType = .no
        counterDescriptionTextField.autocapitalizationType = .sentences
    }
    
    func roundButton() {
        addButton.layer.cornerRadius = 8
    }
    
    func setupKetboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIViewController.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIViewController.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if counterTitleTextField.isEditing && keyboardOverlays(textField: counterTitleTextField, keyboardSize: keyboardSize) {
                self.view.frame.origin.y -= keyboardSize.height
            } else if dateTextField.isEditing && keyboardOverlays(textField: dateTextField, keyboardSize: keyboardSize) {
                self.view.frame.origin.y -= keyboardSize.height
            } else if counterDescriptionTextField.isEditing && keyboardOverlays(textField: counterDescriptionTextField, keyboardSize: keyboardSize) {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func keyboardOverlays(textField: UITextField, keyboardSize: CGRect) -> Bool {
        let keyboardHeight = keyboardSize.height
        let textFieldY = textField.frame.height + textField.frame.origin.y
        return textFieldY >= (self.view.frame.height - keyboardHeight) ? true : false
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if !counterTitleTextField.text!.isEmpty && !dateTextField.text!.isEmpty {
            do {
                try realm.write {
                    let newCounter = Counter()
                    newCounter.name = counterTitleTextField.text ?? "Undefined"
                    newCounter.tillDate = datePicker?.date
                    newCounter.excludeLast = excludeLastSwitch.isOn
                    newCounter.colorHex = UIColor.randomFlat.hexValue()
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
        } else {
            let alert = UIAlertController(title: "Empty Fields", message: "Title and Date fields can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
