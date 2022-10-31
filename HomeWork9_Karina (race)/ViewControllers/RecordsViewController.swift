//
//  RecordsViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit
         
protocol RecordsViewControllerDelegate {
    func changeColor(color: UIColor)
}

class RecordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RecordsViewControllerDelegate {
    
    var tableViewForRecords: UITableView = {
        var tableViewForRecords = UITableView()
        tableViewForRecords.translatesAutoresizingMaskIntoConstraints = false
        tableViewForRecords.layer.cornerRadius = 30
        return tableViewForRecords
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.8363788724, green: 0.9316909909, blue: 0.7094728351, alpha: 1)
        self.view.addSubview(tableViewForRecords)
        
        tableViewForRecords.dataSource = self
        tableViewForRecords.delegate = self
        
        tableViewForRecords.register(RecordsTableViewCell.self, forCellReuseIdentifier: "RecordsTableViewCell")
        
        tableViewForRecords.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110 ).isActive = true
        tableViewForRecords.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        tableViewForRecords.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        tableViewForRecords.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -110).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var arrayOfNames = [String]()
        var arrayOfScores = [String]()
        var cell: UITableViewCell!
        let tempCell = tableView.dequeueReusableCell(withIdentifier: RecordsTableViewCell.id, for: indexPath) as! RecordsTableViewCell
        guard var resultsArray = UserDefaults.standard.value([Results].self, forKey: "records") else { return cell }
        while resultsArray.count > 17 {
            resultsArray.removeFirst()
        }
        for results in resultsArray {
            arrayOfNames.append(results.name)
            arrayOfScores.append(results.score)
        }
        arrayOfNames = arrayOfNames.map { $0 == "" ? "Unnamed Racer" : $0 }
        tempCell.labelForName.text = ("\(String(describing: arrayOfNames[indexPath.row])) - \(String(describing: arrayOfScores[indexPath.row]))")
        cell = tempCell
        tempCell.delegate = self
        return cell
    }
    
    func changeColor(color: UIColor) {
        self.view.backgroundColor = color
    }
}
