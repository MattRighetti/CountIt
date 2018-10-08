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
    
    let realm = try! Realm()
    let cellID = "tableViewCounterCell"
    var counters: Results<Counter>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countersTableView.delegate = self
        countersTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
        refreshDates()
        countersTableView.reloadData()
    }
    
    func reloadData() {
        counters = realm.objects(Counter.self)
    }
    
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
}

extension CountItViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let countersArray = counters {
            return countersArray.count
        } else {
            return 0
        }
    }
    
    // Populate row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let counterCell = countersTableView.dequeueReusableCell(withIdentifier: cellID) as! TableViewCounterCell
        
        if let counterAtCurrentIndexPath = counters?[indexPath.row] {
            counterCell.setTitleLabel(withTitle: counterAtCurrentIndexPath.name)
            counterCell.setDateLabel(withDate: String(counterAtCurrentIndexPath.daysLeft))
        }
        
        return counterCell
    }
    
}
