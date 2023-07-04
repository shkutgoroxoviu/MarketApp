//
//  BasketListPresenter.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation

final class BasketListPresenter: BasketListPresenterProtocol {
    weak var view: BasketListViewProtocol?
    var interactor: BasketListInteractorProtocol?
    var router: BasketListRouterProtocol?
    
    var dishes: [DishCoreDataModel] = [DishCoreDataModel]()
    var cartItems: [(name: String, cost: Double, quantity: Int)] = []
    var counter: Int?
    
    func viewDidLoad() {
        self.interactor?.startFetch()
        reloadData()
    }
    
    func reloadData() {
        view?.reloadData()
        print(dishes)
    }
    
    
    
    func deleteCell(value: Int, name: String, index: Int) {
        if value == 0 {
            interactor?.deleteCell(name: name)
            dishes.remove(at: index)
            reloadData()
        }
    }
    
    func builderForCellInBasket(row: DishCoreDataModel) -> BasketListCellModel {
        return BasketListCellModel(dishName: row.dishName ?? "", price: Int(row.price), weight: Int(row.weight), image: row.image ?? "", counter: Int(row.counter))
    }
}
