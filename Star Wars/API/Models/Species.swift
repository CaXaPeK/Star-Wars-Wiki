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
    let average_height, skin_colors, hair_colors, eye_colors: String?
    let average_lifespan: String?
    let homeworld: String?
    let language: String?
    let people, films: [String]?
    let created, edited: String?
    let url: String?
}

let defaultSpecie = Specie(name: nil, classification: nil, designation: nil, average_height: nil, skin_colors: nil, hair_colors: nil, eye_colors: nil, average_lifespan: nil, homeworld: nil, language: nil, people: nil, films: nil, created: nil, edited: nil, url: nil)

let defaultSpecieList = SpecieList(count: nil, next: nil, previous: nil, results: nil)
