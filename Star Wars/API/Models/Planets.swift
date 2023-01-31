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
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?
}
