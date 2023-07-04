//
//  DishesListRouter.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation
import UIKit

class DishesListRouter: DishesListRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createDishesListModule() -> UIViewController {
        let presenter = DishesListPresenter()
        let interactor = DishesListInteractor()
        let view = DishesListView()
        let router = DishesListRouter()

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToPopUpWindow(model: DishModel) {
        let popUpWindow = PopUpWindow()
        popUpWindow.modalPresentationStyle = .overFullScreen
        popUpWindow.modalTransitionStyle = .crossDissolve
        popUpWindow.config(dishName: model.name, price: model.price, weight: model.weight, image: model.image, description: model.description)
        
        viewController?.present(popUpWindow, animated: true)
    }
}
