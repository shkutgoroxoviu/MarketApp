//
//  Categories.swift
//  TestovoeEffective
//
//  Created by Oleg on 29.06.2023.
//

import Foundation

struct Response: Decodable {
    let сategories: [Category]

    enum CodingKeys: String, CodingKey {
        case сategories
    }
}

struct Category: Decodable {
    let id: Int?
    let name: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

