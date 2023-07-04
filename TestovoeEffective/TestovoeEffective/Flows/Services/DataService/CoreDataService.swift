//
//  CoreDataService.swift
//  TestovoeEffective
//
//  Created by Oleg on 03.07.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    
    func addDish(with dish: BasketListCellModel) {
        let entity = NSEntityDescription.entity(forEntityName: "DishCoreDataModel", in: context)
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! DishCoreDataModel
      
           
        taskObject.dishName = dish.dishName
        taskObject.price = Double(dish.price)
        taskObject.weight = Double(dish.weight)
        taskObject.image = dish.image
        taskObject.counter = Double(dish.counter)
        
        do {
            try context.save()
            print("\(dish.dishName) add ✅✅✅")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteDish(_ dishName: String) {
        let fetchRequest: NSFetchRequest<DishCoreDataModel> = DishCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dishName == %@", dishName)
        
        do {
            let result = try context.fetch(fetchRequest)
            guard !result.isEmpty else { return }
            print("\(dishName) delete ✅✅✅")
            context.delete(result[0])
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchStock() -> [DishCoreDataModel]? {
        let fetchRequest: NSFetchRequest<DishCoreDataModel> = DishCoreDataModel.fetchRequest()
        
        do {
            let models = try context.fetch(fetchRequest)
            return models
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func changeStatus(dishName: String, isBasket: Bool) {
        
        let fetchRequest: NSFetchRequest<DishCoreDataModel> = DishCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dishName == %@",  dishName)
        
        do {
            let result = try context.fetch(fetchRequest)
            guard let dishModel = result.first else { return}
            dishModel.isBasket = isBasket
            if dishModel.isBasket == false {
                deleteDish(dishModel.dishName ?? "")
            }
            
            try context.save()
            print(isBasket ? "\(dishName) save ✅✅✅" : "\(dishName) delete ❌❌❌")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func checkStatus(from dishName: String) -> Bool {
        let fetchRequest: NSFetchRequest<DishCoreDataModel> = DishCoreDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dishName == %@",  dishName)
        
        do {
            if let result = try context.fetch(fetchRequest).first {
                return result.isBasket
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
