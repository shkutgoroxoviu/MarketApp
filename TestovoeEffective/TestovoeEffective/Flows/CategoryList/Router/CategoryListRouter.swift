//
//  CategoryListRouter.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation
import UIKit

class CategoryListRouter: CategoryListRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createCategoryListModule() -> UINavigationController {
        let presenter = CategoryListPresenter()
        let interactor = CategoryListInteractor()
        let view = CategoryListView()
        let router = CategoryListRouter()

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return UINavigationController(rootViewController: view)
    }
    
    func navigateToDishesListModule(title: String) {
        let dishesListModule = DishesListRouter.createDishesListModule()
        dishesListModule.title = title
        viewController?.navigationController?.pushViewController(dishesListModule, animated: false)
    }
}
