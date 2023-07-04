//
//  BasketListPresenterProtocol.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation

protocol BasketListPresenterProtocol: AnyObject {
    var dishes: [DishCoreDataModel] { get set }
    
    func viewDidLoad()
    
    func reloadData()
    
    func builderForCellInBasket(row: DishCoreDataModel) -> BasketListCellModel
    
    func deleteCell(value: Int, name: String, index: Int)
}
