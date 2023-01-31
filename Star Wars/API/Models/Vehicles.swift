// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vehicleList = try? JSONDecoder().decode(VehicleList.self, from: jsonData)

import Foundation

struct VehicleList {
    let count: Int?
    let next: String?
    let previous: String?
    let vehicle: [Vehicle]?
}

struct Vehicle {
    let name, model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, vehicleClass: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
}
