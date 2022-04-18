//
//  Category.swift
//  14.3
//
//  Created by Satyavrata on 15.04.2022.
//

import Foundation
import RealmSwift
//
//struct Category: Codable {
//    let id: Int
//    let name: String
//    let status: String
//    let image: String
//    let gender: String
//    let location: Location
//}
//struct Location: Codable {
//    let name: String
//}

class Category: Codable {
    let id: Int
    let name: String
    let status: String
    let image: String
    let gender: String
    let location: Location

    init(id: Int, name: String, status: String, image: String, gender: String, location: Location) {
        self.id = id
        self.name = name
        self.status = status
        self.image = image
        self.gender = gender
        self.location = location
    }

}
class Location: Codable {
    let name: String
    init(name: String) {
        self.name = name
    }
}

