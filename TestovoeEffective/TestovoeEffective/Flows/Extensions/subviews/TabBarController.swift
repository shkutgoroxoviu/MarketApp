//
//  TabBarController.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTabBar()
        configUI()
    }
    
    private func configUI() {
        tabBar.tintColor = UIColor(red: 0.00, green: 0.30, blue: 0.81, alpha: 1.00)
        view.backgroundColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIImage()
        
        let separatorImage = UIImage(named: "separator_image")
        let separatorImageView = UIImageView(image: separatorImage)
        separatorImageView.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.93, alpha: 1.00)
        separatorImageView.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width, height: 1)
        tabBar.addSubview(separatorImageView)
    }
    
    private func setupTabBar() {
        let categoryVC = CategoryListRouter.createCategoryListModule()
        let tabCategory = UITabBarItem(title: "Главная", image: UIImage(named: "home"), tag: 0)
        categoryVC.tabBarItem = tabCategory
        
        let searchVC = SearchScreenView()
        let tabSearch = UITabBarItem(title: "Поиск", image: UIImage(named: "search"), tag: 1)
        searchVC.tabBarItem = tabSearch
        
        let basketVC = BasketListRouter.createBasketListModule()
        let tabBasket = UITabBarItem(title: "Корзина", image: UIImage(named: "trash"), tag: 2)
        basketVC.tabBarItem = tabBasket
        
        let accVC = AccountView()
        let tabAcc = UITabBarItem(title: "Аккаунт", image: UIImage(named: "acc"), tag: 3)
        accVC.tabBarItem = tabAcc
        
        setViewControllers([categoryVC, searchVC, basketVC, accVC], animated: false)
        
        selectedIndex = 0
    }

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let currentViewController = selectedViewController {
            currentViewController.dismiss(animated: false, completion: nil)
        }
        return true
    }
}
