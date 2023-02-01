// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let planetList = try? JSONDecoder().decode(PlanetList.self, from: jsonData)

import Foundation

struct PlanetList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Planet]?
}

struct Planet: Codable {
    let name, rotation_period, orbital_period, diameter: String?
    let climate, gravity, terrain, surface_water: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
}

let defaultPlanet = Planet(name: nil, rotation_period: nil, orbital_period: nil, diameter: nil, climate: nil, gravity: nil, terrain: nil, surface_water: nil, population: nil, residents: nil, films: nil, created: nil, edited: nil, url: nil)

let defaultPlanetList = PlanetList(count: nil, next: nil, previous: nil, results: nil)
