//
//  GameViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit

class GameViewController: UIViewController {
    
    let settings = UserDefaults.standard.value(Settings.self, forKey: "settings")
    weak var timerForFallingObjects: Timer?
    weak var timerGame: Timer?
    
    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.text = "00:00"
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont(name: "Marker Felt", size: 40)
        timerLabel.frame = CGRect(x: (self.view.frame.width / 3) * 2, y: self.view.frame.size.height / 30, width: self.view.frame.width / 4, height: self.view.frame.size.height / 10)
        return timerLabel
    }()
    
    lazy var carView: UIImageView = {
        let carView = UIImageView()
        if let image = settings?.car {
            let image = UIImage(named: image)
            carView.image = image
        }
        carView.frame = CGRect(x: self.view.frame.size.width / CGFloat(2), y: self.view.frame.size.height / CGFloat(2), width: self.view.frame.size.width / CGFloat(6.5), height: self.view.frame.size.height / CGFloat(7))
        carView.contentMode = .scaleAspectFit
        return carView
    }()
    
    var count: Int = 0
    var fallingObjectsArray = [UIImageView]()
    var namesOfFallingObjects = ["human","policeCar","redCar","trashCan"]
 
    func carMotion() {
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeDetected))
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeDetected))
        leftSwipeRecognizer.direction = .left
        rightSwipeRecognizer.direction = .right
        self.view.addSubview(carView)
        self.view.addGestureRecognizer(leftSwipeRecognizer)
        self.view.addGestureRecognizer(rightSwipeRecognizer)
    }
    
    func animateBackground() {
        let backgroundImage = UIImage(named: "road")

        // UIImageView 1
        let firstBackgroundImageView = UIImageView(image: backgroundImage)
        firstBackgroundImageView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
        firstBackgroundImageView.contentMode = .scaleToFill
        self.view.addSubview(firstBackgroundImageView)

        // UIImageView 2
        let secondBackgroundImageView = UIImageView(image: backgroundImage)
        secondBackgroundImageView.frame = CGRect(x: self.view.frame.origin.x, y: -self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.height)
        secondBackgroundImageView.contentMode = .scaleToFill
        self.view.addSubview(secondBackgroundImageView)

        // Animate background
        UIView.animate(withDuration: 6.0, delay: 0.0, options: [.repeat, .curveLinear], animations: {
            firstBackgroundImageView.frame = firstBackgroundImageView.frame.offsetBy(dx: 0.0, dy: firstBackgroundImageView.frame.size.height)
            secondBackgroundImageView.frame = secondBackgroundImageView.frame.offsetBy(dx: 0.0, dy: secondBackgroundImageView.frame.size.height)
            }, completion: nil)
    }
    
    func roadsideExit() {
        if carView.frame.origin.x < self.carView.frame.size.width || carView.frame.origin.x > 5 * self.carView.frame.size.width {
           crashCarAppear()
        }
    }
    
    func crashCarAppear() {
        let crashImageView: UIImageView = {
            let crashImageView = UIImageView()
            let crashImage = UIImage(named: "crashCar")
            crashImageView.image = crashImage
            crashImageView.contentMode = .scaleAspectFill
            return crashImageView
        }()
        carView.frame = CGRect(x: self.view.frame.size.width / CGFloat(2), y: self.view.frame.size.height / CGFloat(2), width: self.view.frame.size.width / CGFloat(6.5), height: self.view.frame.size.height / CGFloat(7))
        carView.removeFromSuperview()
        self.view.addSubview(crashImageView)
        crashImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / CGFloat(2), height: self.view.frame.size.height / CGFloat(3))
        crashImageView.center = self.view.center
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.tabBarController?.selectedIndex = 2
        }
        timerGame?.invalidate()
    }
    
    func objectsFall() {
        var pointX = CGFloat(self.view.frame.size.width / CGFloat(5))
        var pointY = CGFloat(0) - self.view.frame.size.height / CGFloat(7)
        for name in namesOfFallingObjects {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleToFill
            fallingObjectsArray.append(imageView)
        }

        for imageView in fallingObjectsArray {
            imageView.frame = CGRect(x: pointX, y: pointY,  width: self.view.frame.size.width / CGFloat(7), height: self.view.frame.size.height / CGFloat(7))
            pointX += self.view.frame.size.width / CGFloat(6.5)
            pointY -= self.view.frame.size.height
            self.view.addSubview(imageView)
        }
        
        UIView.animate(withDuration: 20, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.fallingObjectsArray.forEach { $0.frame = $0.frame.offsetBy(dx: 0, dy: self.view.frame.size.height + self.view.frame.size.height * CGFloat(self.fallingObjectsArray.count)) }
        }, completion: nil)
    }
    
    func startTimer() {
        timerForFallingObjects = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
            for view in self.fallingObjectsArray {
                let layerPresentationFrame = view.layer.presentation()?.frame
                if let layerPresentationFrame = layerPresentationFrame, self.carView.frame.intersects(layerPresentationFrame) {
                    self.crashCarAppear()
                }
            }
        }
    }
    
    func timerGameAdded() {
        timerGame = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        self.view.addSubview(timerLabel)
    }
    
    @objc func timerCounter() -> Void {
        count += 1
        let time = secondToMinutesSeconds(seconds: count)
        let timeString = makeTimeToString(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
    }
    
    func secondToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }
    
    func makeTimeToString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func restoreSettings() {
        let settings = UserDefaults.standard.value(Settings.self, forKey: "settings")
        if let carSettings = settings?.car {
            carView.image = UIImage(named: carSettings)
        }
        if let obstacles = settings?.obstacles {
            namesOfFallingObjects = []
            fallingObjectsArray = []
            namesOfFallingObjects.append(contentsOf: obstacles)
        }
    }
    
    func gameOver() {
        let settings = UserDefaults.standard.value(Settings.self, forKey: "settings")
        timerGame?.invalidate()
        timerForFallingObjects?.invalidate()
        guard let nickname = settings?.name else { return }
        guard let text = timerLabel.text else { return }
        let records = Results(name: nickname, score: text)
        var recordsArray = UserDefaults.standard.value([Results].self, forKey: "records") ?? [Results]()
        recordsArray.append(records)
        UserDefaults.standard.set(encodable: recordsArray, forKey: "records")
        count = 0
        timerLabel.text = "00:00"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateBackground()
        carMotion()
        startTimer()
        timerGameAdded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        restoreSettings()
        objectsFall()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        gameOver()
    }

    @IBAction func leftSwipeDetected() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {
            self.carView.frame.origin.x -= self.carView.frame.size.width
        }, completion: nil)
        roadsideExit()
    }

    @IBAction func rightSwipeDetected() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
            self.carView.frame.origin.x += self.carView.frame.size.width
        } , completion: nil)
        roadsideExit()
    }
}
