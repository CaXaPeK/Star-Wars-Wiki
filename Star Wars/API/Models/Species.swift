// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let specieList = try? JSONDecoder().decode(SpecieList.self, from: jsonData)

import Foundation

struct SpecieList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Specie]?
}

struct Specie: Codable {
    let name, classification: String?
    let designation: String?
    let averageHeight, skinColors, hairColors, eyeColors: String?
    let averageLifespan: String?
    let homeworld: String?
    let language: String?
    let people, films: [String]?
    let created, edited: String?
    let url: String?
}
