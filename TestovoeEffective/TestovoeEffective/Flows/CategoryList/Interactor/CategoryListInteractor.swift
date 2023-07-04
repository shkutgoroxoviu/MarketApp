//
//  CategoryListInteractor.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation

final class CategoryListInteractor: CategoryListInteractorProtocol {
    weak var presenter: CategoryListPresenterProtocol?
    
    let networkService = Network()
    
    var urlForCategories = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
    
    func startFetch() {
        self.networkService.fetchCategories(url: self.urlForCategories) { [weak self] response in
            self?.presenter?.сategories = response
            self?.presenter?.reloadData()
        }
    }
}
