//
//  PopUpWindow.swift
//  TestovoeEffective
//
//  Created by Oleg on 02.07.2023.
//

import Foundation
import UIKit

protocol AcceptInfo: AnyObject {
    func accept(bool: Bool)
}

class PopUpWindow: UIViewController {
    private let popUpWindowView = PopUpWindowView()
    
    weak var delegate: AcceptInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        createGestureRecognizer()
    }
    
    private func configUI() {
        view = popUpWindowView
        popUpWindowView.delegate = self
        popUpWindowView.delegate1 = self
    }
    
    func config(dishName: String, price: Int, weight: Int, image: String, description: String) {
        popUpWindowView.config(model: DishModel(name: dishName, price: price, weight: weight, image: image, description: description, id: 0))
    }
    
    private func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tap.cancelsTouchesInView = false

        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}

extension PopUpWindow: DidTapCloseButton {
    func didTapClose(bool: Bool) {
        if bool == true {
            dismiss(animated: true)
        } else {
            return
        }
    }
}

extension PopUpWindow: DidTapBasketButton {
    func didTapBasket(bool: Bool) {
        delegate?.accept(bool: bool)
        dismiss(animated: true)
    }
}
