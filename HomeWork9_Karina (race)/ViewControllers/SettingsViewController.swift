//
//  SettingsViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit

enum Direction {
    case previous
    case next
}

class SettingsViewController: UIViewController {
    
    let typesOfCars = ["yellowCar", "blueCar", "tractor", "whiteCar", "grayCar"]
    let typesOfObstacles = [["human", "policeCar", "trashCan", "redCar"],["bird", "beam", "fox", "rabbit"],["zombie1", "zombie2", "zombie3", "zombie4"]]
    
    lazy var textFieldForName: UITextField = {
        var textFieldForName = UITextField()
        textFieldForName.placeholder = "Enter your name"
        textFieldForName.frame = CGRect(x: self.view.frame.size.width / 6, y: self.view.frame.size.height / 7, width: self.view.frame.size.width * 2 / 3, height: self.view.frame.size.height / 18)
        textFieldForName.borderStyle = .roundedRect
        textFieldForName.font = UIFont(name: "Marker Felt", size: 20)
        return textFieldForName
    }()
    
    lazy var imageViewForCar: UIImageView = {
        var imageViewForCar = UIImageView()
        imageViewForCar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height / 4)
        imageViewForCar.center.x = self.view.center.x
        imageViewForCar.center.y = self.view.center.y - 100
        imageViewForCar.contentMode = .scaleAspectFit
        imageViewForCar.image = UIImage(named: typesOfCars[carIndex])
        return imageViewForCar
    }()
    
    lazy var showNextCarButton: UIButton = {
        var showNextCarButton = UIButton()
        showNextCarButton.setBackgroundImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        showNextCarButton.translatesAutoresizingMaskIntoConstraints = false
        showNextCarButton.tintColor = .tabBarItemAccent
        return showNextCarButton
    }()
    
    lazy var showPreviousCarButton: UIButton = {
        var showPreviousCarButton = UIButton()
        showPreviousCarButton.setBackgroundImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        showPreviousCarButton.translatesAutoresizingMaskIntoConstraints = false
        showPreviousCarButton.tintColor = .tabBarItemAccent
        return showPreviousCarButton
    }()
    
    lazy var showNextObstacleButton: UIButton = {
        var showNextObstacleButton = UIButton()
        showNextObstacleButton.setBackgroundImage(UIImage(systemName: "arrow.right.circle"), for: .normal)
        showNextObstacleButton.translatesAutoresizingMaskIntoConstraints = false
        showNextObstacleButton.tintColor = .tabBarItemAccent
        return showNextObstacleButton
    }()
    
    lazy var showPreviousObstacleButton: UIButton = {
        var showPreviousObstacleButton = UIButton()
        showPreviousObstacleButton.setBackgroundImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        showPreviousObstacleButton.translatesAutoresizingMaskIntoConstraints = false
        showPreviousObstacleButton.tintColor = .tabBarItemAccent
        return showPreviousObstacleButton
    }()
    
    lazy var horizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 5
        horizontalStackView.frame = CGRect(x: 0, y: 0,  width: self.view.frame.size.width / 1.2, height: self.view.frame.size.height / 4)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        for view in typesOfObstacles[obstacleIndex] {
            let imageView = UIImageView()
            imageView.contentMode = .scaleToFill
            let image = UIImage(named: view)
            imageView.image = image
            horizontalStackView.addArrangedSubview(imageView)
        }
        return horizontalStackView
    }()
    
    var carIndex = 0
    var obstacleIndex = 0
    
    func showCarOptions(_ direction: Direction) {
        switch direction {
        case .previous:
            if carIndex > 0 {
                carIndex -= 1
            } else {
                carIndex = typesOfCars.count - 1
            }
            imageViewForCar.image = UIImage(named: typesOfCars[carIndex])
        case .next:
            if carIndex < typesOfCars.count - 1 {
                carIndex += 1
            } else {
                carIndex = 0
            }
            imageViewForCar.image = UIImage(named: typesOfCars[carIndex])
        }
    }
    
    func showObstaclesOptions(_ direction: Direction) {
        switch direction {
        case .previous:
            if obstacleIndex > 0 {
                obstacleIndex -= 1
            } else {
                obstacleIndex = typesOfObstacles.count - 1
            }
            for view in horizontalStackView.subviews {
                view.removeFromSuperview()
            }
            for view in typesOfObstacles[obstacleIndex] {
                let imageView = UIImageView()
                let image = UIImage(named: view)
                imageView.image = image
                horizontalStackView.addArrangedSubview(imageView)
            }
        case .next:
            if obstacleIndex < typesOfObstacles.count - 1 {
                obstacleIndex += 1
            } else {
                obstacleIndex = 0
            }
            for view in horizontalStackView.subviews {
                view.removeFromSuperview()
            }
            for view in typesOfObstacles[obstacleIndex] {
                let imageView = UIImageView()
                let image = UIImage(named: view)
                imageView.image = image
                horizontalStackView.addArrangedSubview(imageView)
            }
        }
    }
    
    func saveSettings() {
        guard let nickname = textFieldForName.text else { return }
        
        let settings = Settings(name: nickname, car: typesOfCars[carIndex], obstacles: typesOfObstacles[obstacleIndex])
        UserDefaults.standard.set(encodable: settings, forKey: "settings")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.8363788724, green: 0.9316909909, blue: 0.7094728351, alpha: 1)
        
        self.view.addSubview(textFieldForName)
        self.view.addSubview(imageViewForCar)
        self.view.addSubview(showNextCarButton)
        self.view.addSubview(showPreviousCarButton)
        self.view.addSubview(showNextObstacleButton)
        self.view.addSubview(showPreviousObstacleButton)
        self.view.addSubview(horizontalStackView)
        
        showPreviousCarButton.addAction(UIAction(handler: { action in self.showCarOptions(.previous) }), for: .touchUpInside)
        showNextCarButton.addAction(UIAction(handler: { action in self.showCarOptions(.next) }), for: .touchUpInside)
        
        showPreviousObstacleButton.addAction(UIAction(handler: { action in self.showObstaclesOptions(.previous)}), for: .touchUpInside)
        showNextObstacleButton.addAction(UIAction(handler: { action in self.showObstaclesOptions(.next)}), for: .touchUpInside)
        
        let leftConstraintForNextCarButton = NSLayoutConstraint(item: showNextCarButton, attribute: .left, relatedBy: .equal, toItem: imageViewForCar, attribute: .right, multiplier: 1, constant: +10)
        let topConstraintForNextCarButton = NSLayoutConstraint(item: showNextCarButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 300)
        let widthConstraintForNextCarButton = NSLayoutConstraint(item: showNextCarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.view.frame.size.width / 6)
        let heightConstraintForNextCarButton = NSLayoutConstraint(item: showNextCarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.width / 6)
        
        let leftConstraintForPreviousCarButton = NSLayoutConstraint(item: showPreviousCarButton, attribute: .right, relatedBy: .equal, toItem: imageViewForCar, attribute: .left, multiplier: 1, constant: -10)
        let topConstraintForPreviousCarButton = NSLayoutConstraint(item: showPreviousCarButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 300)
        let widthConstraintForPreviousCarButton = NSLayoutConstraint(item: showPreviousCarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.view.frame.size.width / 6)
        let heightConstraintForPreviousCarButton = NSLayoutConstraint(item: showPreviousCarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.width / 6)
        
        let leftConstraintForNextObstacleButton = NSLayoutConstraint(item: showNextObstacleButton, attribute: .left, relatedBy: .equal, toItem: horizontalStackView, attribute: .right, multiplier: 1, constant: 0)
        let topConstraintForNextObstacleButton = NSLayoutConstraint(item: showNextObstacleButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 500)
        let widthConstraintForNextObstacleButton = NSLayoutConstraint(item: showNextObstacleButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.view.frame.size.width / 10)
        let heightConstraintForNextObstacleButton = NSLayoutConstraint(item: showNextObstacleButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.width / 10)
        
        let rightConstraintForPreviousObstacleButton = NSLayoutConstraint(item: showPreviousObstacleButton, attribute: .right, relatedBy: .equal, toItem: horizontalStackView, attribute: .left, multiplier: 1, constant: 0)
        let topConstraintForPreviousObstacleButton = NSLayoutConstraint(item: showPreviousObstacleButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 500)
        let widthConstraintForPreviousObstacleButton = NSLayoutConstraint(item: showPreviousObstacleButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: self.view.frame.size.width / 10)
        let heightConstraintForPreviousObstacleButton = NSLayoutConstraint(item: showPreviousObstacleButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.width / 10)
        
        let leftConstraintForHorizontalStackView = NSLayoutConstraint(item: horizontalStackView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 40)
        let rightConstraintForHorizontalStackView = NSLayoutConstraint(item: horizontalStackView, attribute: .right, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: -40)
        let topConstraintForHorizontalStackView = NSLayoutConstraint(item: horizontalStackView, attribute: .top, relatedBy: .equal, toItem: imageViewForCar, attribute: .bottom, multiplier: 1, constant: 50)
        let heightConstraintForHorizontalStackView = NSLayoutConstraint(item: horizontalStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.width / 5)
        
        self.view.addConstraints([leftConstraintForNextCarButton, topConstraintForNextCarButton, widthConstraintForNextCarButton, heightConstraintForNextCarButton, leftConstraintForPreviousCarButton, topConstraintForPreviousCarButton, widthConstraintForPreviousCarButton, heightConstraintForPreviousCarButton, leftConstraintForHorizontalStackView, rightConstraintForHorizontalStackView, topConstraintForHorizontalStackView, heightConstraintForHorizontalStackView, rightConstraintForPreviousObstacleButton,topConstraintForPreviousObstacleButton, widthConstraintForPreviousObstacleButton, heightConstraintForPreviousObstacleButton, leftConstraintForNextObstacleButton, widthConstraintForNextObstacleButton, heightConstraintForNextObstacleButton, topConstraintForNextObstacleButton])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
        
    }
}
