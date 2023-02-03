// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let starshipList = try? JSONDecoder().decode(StarshipList.self, from: jsonData)

import Foundation

struct StarshipList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Starship]?
}

struct Starship: Codable {
    let name, model, manufacturer, cost_in_credits: String?
    let length, max_atmosphering_speed, crew, passengers: String?
    let cargo_capacity, consumables, hyperdrive_rating, mglt: String?
    let starship_class: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
}

let defaultStarship = Starship(name: nil, model: nil, manufacturer: nil, cost_in_credits: nil, length: nil, max_atmosphering_speed: nil, crew: nil, passengers: nil, cargo_capacity: nil, consumables: nil, hyperdrive_rating: nil, mglt: nil, starship_class: nil, pilots: nil, films: nil, created: nil, edited: nil, url: nil)

let defaultStarshipList = StarshipList(count: nil, next: nil, previous: nil, results: nil)
