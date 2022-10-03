//
//  GameViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit

class GameViewController: UIViewController, UICollisionBehaviorDelegate {
  
    weak var timer: Timer?
    
    lazy var carView: UIImageView = {
        let carView = UIImageView()
        let image = UIImage(named: "yellowCar")
        carView.image = image
        carView.frame = CGRect(x: self.view.frame.size.width / CGFloat(2), y: self.view.frame.size.height / CGFloat(2), width: self.view.frame.size.width / CGFloat(6.5), height: self.view.frame.size.height / CGFloat(7))
        carView.contentMode = .scaleAspectFit
        return carView
    }()

    var fallingObjectsArray = [UIImageView]()
    let namesOfFallingObjects = ["human","policeCar","redCar","trashСan"]
    
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateBackground()
        carMotion()
        objectsFall()
        startTimer()
    }


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
        let backgroundImage = UIImage(named:"road")

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
        carView.removeFromSuperview()
        self.view.addSubview(crashImageView)
        crashImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width / CGFloat(2), height: self.view.frame.size.height / CGFloat(3))
        crashImageView.center = self.view.center
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popToRootViewController(animated: true)
        }
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
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {_ in
            for view in self.fallingObjectsArray {
                if self.carView.frame.intersects(view.layer.presentation()!.frame) {
                    self.crashCarAppear()
                }
            }
        }
    }
}

