//
//  Network.swift
//  TestovoeEffective
//
//  Created by Oleg on 29.06.2023.
//

import Foundation

class Network {
    func fetchCategories(url: String, complitions: @escaping (Response) -> Void) {
           guard let url = URL(string: url) else {
               print("Invalid URL")
               return
           }
           
           let request = URLRequest(url: url)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   print("Error: \(error.localizedDescription)")
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               do {
                   let categories = try self.parseJson(type: Response.self, data: data)
                   complitions(categories)
               } catch {
                   print("Error decoding JSON: \(error.localizedDescription)")
               }
           }.resume()
    }
    
    func fetchDishes(url: String, complitions: @escaping (ResponseDishes) -> Void) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let dishes = try self.parseJson(type: ResponseDishes.self, data: data)
                complitions(dishes)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
 }
    
    private func parseJson<T: Decodable>(type: T.Type, data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try decoder.decode(T.self, from: data)
        return model
    }
}
