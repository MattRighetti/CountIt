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
        countersTableView.reloadData()
    }
    
    func reloadData() {
        counters = realm.objects(Counter.self)
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
        let counterCell = countersTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCounterCell
        
        if let counterAtCurrentIndexPath = counters?[indexPath.row] {
            counterCell.setTitleLabel(withTitle: counterAtCurrentIndexPath.name)
        }
        
        return counterCell
    }
    
}
