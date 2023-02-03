// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let vehicleList = try? JSONDecoder().decode(VehicleList.self, from: jsonData)

import Foundation

struct VehicleList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Vehicle]?
}

struct Vehicle: Codable {
    let name, model, manufacturer, cost_in_credits: String?
    let length, max_atmosphering_speed, crew, passengers: String?
    let cargo_capacity, consumables, vehicle_class: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
}

let defaultVehicle = Vehicle(name: nil, model: nil, manufacturer: nil, cost_in_credits: nil, length: nil, max_atmosphering_speed: nil, crew: nil, passengers: nil, cargo_capacity: nil, consumables: nil, vehicle_class: nil, pilots: nil, films: nil, created: nil, edited: nil, url: nil)

let defaultVehicleList = VehicleList(count: nil, next: nil, previous: nil, results: nil)
