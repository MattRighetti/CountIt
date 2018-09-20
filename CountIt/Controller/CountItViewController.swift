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
    
    var counters: [Counter] = [
        Counter(),
        Counter(),
        Counter(),
        Counter()
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        countersTableView.delegate = self
        countersTableView.dataSource = self
        countersTableView.register(CounterCell.self, forCellReuseIdentifier: "counterCell")
        counters[0].name = "First"
        counters[1].name = "Second"
        counters[2].name = "Third"
        counters[3].name = "Fourth"
    }
}

extension CountItViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let counterCell = countersTableView.dequeueReusableCell(withIdentifier: "counterCell") as! CounterCell
        counterCell.counterNameLabel.text = counters[indexPath.row].name
        counterCell.daysLeftLabel.text = String(counters[indexPath.row].daysTillDate)
        return counterCell
    }
    
}
