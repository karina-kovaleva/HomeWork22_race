//
//  RecordsViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit

class RecordsViewController: UIViewController {

    lazy var labelForResults: UILabel = {
        var labelForResults = UILabel()
        labelForResults.numberOfLines = 0
        labelForResults.textAlignment = .center
        labelForResults.lineBreakMode = .byWordWrapping
        labelForResults.text = "Racer - Score\n"
        labelForResults.font = UIFont(name: "Marker Felt", size: 30)
        labelForResults.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.size.height / 10, width: self.view.frame.size.width, height: self.view.frame.size.height * 0.7)
        return labelForResults
    }()
    
    func updateRecords() {
        guard var resultsArray = UserDefaults.standard.value([Results].self, forKey: "records") else { return }
        var text = "Racer - Score\n"
        while resultsArray.count > 17 {
            resultsArray.removeFirst()
        }
        for results in resultsArray {
            if results.name == "" {
                text += ("Unnamed Racer - \(String(describing: results.score))\n")
                labelForResults.text = text
            } else {
                
                text += ("\(String(describing: results.name)) - \(String(describing: results.score))\n")
                labelForResults.text = text
            }
        }
        text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8363788724, green: 0.9316909909, blue: 0.7094728351, alpha: 1)
        self.view.addSubview(labelForResults)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateRecords()
        
    }
}
