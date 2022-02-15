//
//  TabBarController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/13.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainViewController = UINavigationController(rootViewController: mainViewController())
        mainViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        let settingViewController = UserListViewController()
        settingViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [mainViewController, settingViewController]
    }
}
