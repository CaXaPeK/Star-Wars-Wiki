// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let peoples = try? JSONDecoder().decode(Peoples.self, from: jsonData)

import Foundation

struct PeopleList: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Person]?
}

struct Person: Codable {
    let name, height, mass, hairColor: String?
    let skinColor, eyeColor, birthYear: String?
    let gender: String?
    let homeworld: String?
    let films, species, vehicles, starships: [String]?
    let created, edited: String?
    let url: String?
}
