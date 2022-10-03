//
//  ViewController.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 12.08.22.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        self.selectedViewController = self.viewControllers![1] 
    }
    
    func generateTabBar() {
        viewControllers = [generateVC(viewcontroller: SettingsViewController(), title: "Settings", image: UIImage(systemName: "gearshape.circle")), generateVC(viewcontroller: GameViewController(), title: "Game", image: UIImage(systemName: "gamecontroller")), generateVC(viewcontroller: RecordsViewController(), title: "Records", image: UIImage(systemName: "rosette"))]
    }
    
    func generateVC (viewcontroller: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewcontroller.tabBarItem.title = title
        viewcontroller.tabBarItem.image = image
        return viewcontroller
    }
    
    func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.layer.borderColor = UIColor.black.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}

