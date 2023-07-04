//
//  DishesListPresenter.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation

class DishesListPresenter: DishesListPresenterProtocol {
    weak var view: DishesListViewProtocol?
    var interactor: DishesListInteractorProtocol?
    var router: DishesListRouterProtocol?
    
    var dishes: ResponseDishes?
    var tegs: [String] = ["Все меню", "Салаты", "С рисом", "С рыбой"]
    var currentList: [Dish] = [Dish]()
    var tegList: [Dish] = [Dish]()
    
    func viewDidLoad() {
        self.interactor?.startFetch()
    }
    
    func sortDishesByTeg(teg: Teg, index: Int) {
        tegList = currentList.filter { dish in
            return dish.tegs.contains(teg)
        }
        
        reloadData()
    }
    
    func presentPopUpWindow(_ model: DishModel) {
        router?.navigateToPopUpWindow(model: model)
    }
    
    func checkStatus(dishName: String)  {
        interactor?.checkStatus(dishName: dishName)
    }
    
    func changeStatus(dishName: String, bool: Bool) {
        interactor?.changeStatus(dishName: dishName, bool: bool)
        checkStatus(dishName: dishName)
    }
    
    func addInBasket(name: String) {
        if view?.condition == false {
            for item in currentList {
                if item.name == name {
                    interactor?.addInBasket(model: builderForCellInBasket(row: item))
                }
            }
        } else {
            for item in tegList {
                if item.name == name {
                    interactor?.addInBasket(model: builderForCellInBasket(row: item))
                }
            }
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }
    
    func builderForCell(row: Dish) -> DishModel {
        return DishModel(name: row.name, price: row.price, weight: row.weight, image: row.imageURL, description: row.description, id: row.id)
    }
    
    func builderForCellInBasket(row: Dish) -> BasketListCellModel {
        return BasketListCellModel(dishName: row.name, price: row.price, weight: row.weight, image: row.imageURL, counter: 1)
    }
}
