//
//  CountItViewController.swift
//  CountIt
//
//  Created by Mattia Righetti on 20/09/2018.
//  Copyright © 2018 Mattia Righetti. All rights reserved.
//

import UIKit

class CountItViewController: UIViewController {
    
    @IBOutlet weak var countersTableView: UITableView!
    
    let cellID = "tableViewCounterCell"
    
    var counters: [Counter] = [
        Counter(),
        Counter(),
        Counter(),
        Counter()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        populateArray()
        countersTableView.delegate = self
        countersTableView.dataSource = self
    }
    
    func populateArray() {
        counters[0].name = "First"
        counters[1].name = "Second"
        counters[2].name = "Third"
        counters[3].name = "Fourth"
    }
}

extension CountItViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    // Number of sections in a row
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Populate row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let counterCell = countersTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCounterCell
        let counterAtCurrentIndexPath = counters[indexPath.row]
        if let textLabel = counterCell.counterTitle {
            textLabel.text = counterAtCurrentIndexPath.name
        } else {
            print("No textLabel")
        }
        return counterCell
    }
    
}
