//
//  BasketListInteractor.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation

final class BasketListInteractor: BasketListInteractorProtocol {
    weak var presenter: BasketListPresenterProtocol?
    
    var coreDataService = CoreDataService()
    
    func startFetch() {
        guard let model = coreDataService.fetchStock() else { return }
        presenter?.dishes = model
        presenter?.reloadData()
    }
    
    func deleteCell(name: String) {
        coreDataService.deleteDish(name)
    }
}
