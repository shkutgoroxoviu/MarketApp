//
//  CategoryListPresenterProtocol.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation

protocol CategoryListPresenterProtocol: AnyObject {
    var сategories: Response? { get set }
    
    func viewDidLoad()
    
    func builderForCell(row: Category) -> CategoryModel
    
    func reloadData()
    
    func pushDishesListView(title: String)
}
