//
//  CustomNavigationController.swift
//  TestovoeEffective
//
//  Created by Oleg on 29.06.2023.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
        ]
        hidesBottomBarWhenPushed = false
    }
}
