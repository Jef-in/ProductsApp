//
//  TabBarController.swift
//  ProductsApp
//
//  Created by Jefin on 18/05/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarView()
    }
    
    func configureTabBarView() {
       tabBar.frame = CGRect(x: 0, y: 0, width: 375, height: 95)
       tabBar.layer.cornerRadius = 12.0
       tabBar.layer.masksToBounds = true
    }
}
