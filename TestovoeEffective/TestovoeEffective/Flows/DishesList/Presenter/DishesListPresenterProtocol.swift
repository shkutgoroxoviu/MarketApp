//
//  DishesListPresenterProtocol.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation

protocol DishesListPresenterProtocol: AnyObject {
    var dishes: ResponseDishes? { get set }
    
    var tegs: [String] { get set }
    
    var currentList: [Dish] { get set }
    
    var tegList: [Dish] { get set }
    
    func viewDidLoad()
    
    func sortDishesByTeg(teg: Teg, index: Int)
    
    func reloadData()
    
    func builderForCell(row: Dish) -> DishModel
    
    func presentPopUpWindow(_ model: DishModel)
    
    func addInBasket(name: String)
    
    func checkStatus(dishName: String)
    
    func changeStatus(dishName: String, bool: Bool)
}
