//
//  MainTabBarController.swift
//  iMusic
//
//  Created by RAFAEL on 28.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: SearchMusicViewController(),
                                   image: #imageLiteral(resourceName: "Search"), title: "Search"),
            generateViewController(rootViewController: ViewController(), image: #imageLiteral(resourceName: "Library"),
                                   title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
        
    }
}
