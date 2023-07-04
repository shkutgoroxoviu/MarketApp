//
//  DishesListViewProtocol.swift
//  TestovoeEffective
//
//  Created by Oleg on 01.07.2023.
//

import Foundation

protocol DishesListViewProtocol: AnyObject {
    var condition: Bool { get set }
    
    func reloadData()
    
    func config(title: String)
}
