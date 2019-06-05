//
//  CountItViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import UIKit
import RealmSwift

class CountItViewController: UIViewController {
    
    @IBOutlet weak var countersTableView: UITableView!
    
    /// Realm Database to where *Counters* are retrieved and saved
    let realm = try! Realm()
    /// ID of the reusable cell
    let cellID = "tableViewCounterCell"
    /// ID of the CreateCounterViewController Storyboard view
    let viewID = "edit_createViewController"
    /// Every **Counter** that is saved locally on the Realm Database
    var counters: Results<Counter>?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupNavigationTitle()
        setupTableViewDelegates()
        setupEditButtonForTableView()
        setupTableViewAttributes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        refreshDates()
        setupNavigationTitle()
        countersTableView.reloadData()
    }
    
    /**
     Sets the NavigationController title to "Counters" and sets it to be displayed as a large title
     */
    func setupNavigationTitle() {
        navigationItem.title = "Counters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /**
     Sets the **delegate** and **datasource** to this ViewController
     */
    func setupTableViewDelegates() {
        countersTableView.delegate = self
        countersTableView.dataSource = self
    }
    
    func setupTableViewAttributes() {
        countersTableView.separatorStyle = .singleLine
        countersTableView.tableFooterView = UIView(frame: .zero)
    }
    
    /**
     Allows to edit the tableView if there's at least one **Counter** in it, disables selection if the tableView is not in edit mode and allows
     selection if the tableView is in edit mode
     */
    func setupEditButtonForTableView() {
        if counters?.count != 0 {
            navigationItem.leftBarButtonItem = editButtonItem
        }
        
        countersTableView.allowsSelectionDuringEditing = true
        countersTableView.allowsSelection = false
    }
    
    /**
     Queries the Realm Database and retrieves every **Counter** stored locally, ordering them by nearest date
     */
    func reloadData() {
        counters = realm.objects(Counter.self)
        counters = counters!.sorted(byKeyPath: "daysLeft", ascending: true)
    }
    
    /**
     Updates the **Counter.daysLeft** attribute that will be displayed in the **countersTableView**
     */
    func refreshDates() {
        if let counters = counters {
            for counter in counters {
                do {
                    try realm.write {
                        counter.countDays()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    /**
     Changes the state of the **countersTableView**
     1. When the tableView is not in edit mode the button displays "Edit"
     2. When the tableView is in edit mode the button displays "Done"
     */
    override func setEditing(_ editing: Bool, animated: Bool) {
        navigationItem.leftBarButtonItem?.title = !countersTableView.isEditing ? "Done" : "Edit"
        countersTableView.setEditing(!countersTableView.isEditing, animated: true)
    }
    
}

//MARK: - Hide keyboard when backgroud is tapped

extension UIViewController {
    /**
     Hides the keyboard whenever the keyboard is displayed and I tap outside of its frame
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - TableView Methods

extension CountItViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countersArray = counters {
            return countersArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let counterCell = countersTableView.dequeueReusableCell(withIdentifier: cellID) as! TableViewCounterCell
        
        if let counterAtCurrentIndexPath = counters?[indexPath.row] {
            counterCell.setCell(withTitle: counterAtCurrentIndexPath.name, withDays: String(counterAtCurrentIndexPath.daysLeft), withDescription: counterAtCurrentIndexPath.counterDescription, withColor: UIColor(hexString: counterAtCurrentIndexPath.colorHex)!)
        }
        
        return counterCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                if let counterToBeDeleted = counters?[indexPath.row] {
                    try realm.write {
                        realm.delete(counterToBeDeleted)
                    }
                    
                    countersTableView.deleteRows(at: [indexPath], with: .fade)
                }
            } catch {
                print(error)
            }
        }
    }
    
    /**
     This function is called whenever the TableView is in *editMode* and will prepare the *CreateCounterTableViewController*
     with the counter at *indexPath.row*
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let editCounterViewController = storyboard.instantiateViewController(withIdentifier: viewID) as? CreateCounterTableViewController else {
            print("Error initializing view")
            return
        }
        
        editCounterViewController.counter = counters![indexPath.row]
        navigationController?.pushViewController(editCounterViewController, animated: true)
    }
    
}
