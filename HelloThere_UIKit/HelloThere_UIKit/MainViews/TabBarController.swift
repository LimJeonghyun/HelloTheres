//
//  TabBarController.swift
//  HelloThere_UIKit
//
//  Created by 임정현 on 2024/08/09.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        
        let vc1 = ChattingPageViewController()
        let vc2 = MainPageViewController()
        let vc3 = MyPageViewController()
        
        
        let originalImage1 = UIImage(named: "icon_chatting")
        let selectedImage1 = UIImage(named: "icon_chatting")?.withRenderingMode(.alwaysOriginal)
        
        let originalImage2 = UIImage(named: "icon_home")
        let selectedImage2 = UIImage(named: "icon_home")?.withRenderingMode(.alwaysOriginal)
        
        let originalImage3 = UIImage(named: "icon_myPage")
        let selectedImage3 = UIImage(named: "icon_myPage")?.withRenderingMode(.alwaysOriginal)
        
        vc1.tabBarItem.image = originalImage1
        vc1.tabBarItem.selectedImage = selectedImage1
        
        vc2.tabBarItem.image = originalImage2
        vc2.tabBarItem.selectedImage = selectedImage2
        
        vc3.tabBarItem.image = originalImage3
        vc3.tabBarItem.selectedImage = selectedImage3
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
    func setupStyle() {
        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.5, x: 0, y: 0, blur: 12)
    }
}
