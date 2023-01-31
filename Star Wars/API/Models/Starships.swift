// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let starshipList = try? JSONDecoder().decode(StarshipList.self, from: jsonData)

import Foundation

struct StarshipList {
    let count: Int?
    let next: String?
    let previous: String?
    let starship: [Starship]?
}

struct Starship {
    let name, model, manufacturer, costInCredits: String?
    let length, maxAtmospheringSpeed, crew, passengers: String?
    let cargoCapacity, consumables, hyperdriveRating, mglt: String?
    let starshipClass: String?
    let pilots, films: [String]?
    let created, edited: String?
    let url: String?
}
