//
//  StartViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 13.08.22.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.6865376234, green: 0.9314117432, blue: 0.8861546516, alpha: 1)
        startGameButton.setTitle("START GAME", for: .normal)
        startGameButton.titleLabel?.numberOfLines = 0
        startGameButton.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        startGameButton.center = self.view.center
        startGameButton.titleLabel?.font = UIFont(name: "Marker Felt", size: 30)
    }
    
    @IBAction func toGameVCButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "FromStartToGame", sender: "0")
    }
}
