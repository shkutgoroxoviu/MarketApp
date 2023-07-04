//
//  DishesListInteractor.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation

class DishesListInteractor: DishesListInteractorProtocol {
    weak var presenter: DishesListPresenterProtocol?
    
    let networkService = Network()
    let coreDataService = CoreDataService()
    
    var urlForDishes = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
    
    func startFetch() {
        self.networkService.fetchDishes(url: self.urlForDishes) { [weak self] response in
            self?.presenter?.currentList = response.dishes
            self?.presenter?.dishes = response
            self?.presenter?.reloadData()
        }
    }
    
    func checkStatus(dishName: String) {
        if coreDataService.checkStatus(from: dishName) == false {
            print(coreDataService.checkStatus(from: dishName))
            presenter?.addInBasket(name: dishName)
        }
    }
    
    func changeStatus(dishName: String, bool: Bool) {
        coreDataService.changeStatus(dishName: dishName, isBasket: bool)
    }
    
    func addInBasket(model: BasketListCellModel) {
        coreDataService.addDish(with: model)
    }
}
