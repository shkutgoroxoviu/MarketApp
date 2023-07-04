//
//  BasketListRouter.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation
import UIKit

final class BasketListRouter: BasketListRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createBasketListModule() -> UINavigationController {
        let presenter = BasketListPresenter()
        let interactor = BasketListInteractor()
        let view = BasketListView()
        let router = BasketListRouter()

        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return UINavigationController(rootViewController: view)
    }

}
