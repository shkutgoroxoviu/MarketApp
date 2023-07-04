//
//  DishesListInteractorProtocol.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation

protocol DishesListInteractorProtocol {
    func startFetch()
    
    func checkStatus(dishName: String)
    
    func addInBasket(model: BasketListCellModel)
    
    func changeStatus(dishName: String, bool: Bool)
}
