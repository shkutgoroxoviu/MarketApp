//
//  CategoryListPresenter.swift
//  TestovoeEffective
//
//  Created by Oleg on 28.06.2023.
//

import Foundation

final class CategoryListPresenter: CategoryListPresenterProtocol {
    weak var view: CategoryListViewProtocol?
    var interactor: CategoryListInteractorProtocol?
    var router: CategoryListRouterProtocol?
    
    var сategories: Response?
    
    func viewDidLoad() {
        self.interactor?.startFetch()
    }
    
    func reloadData() {
        DispatchQueue.main.sync {
            view?.reloadData()
        }
    }
    
    func pushDishesListView(title: String) {
        router?.navigateToDishesListModule(title: title)
    }
    
    func builderForCell(row: Category) -> CategoryModel {
        return CategoryModel(id: row.id ?? 0, name: row.name ?? "", image: row.imageURL ?? "")
    }
}
