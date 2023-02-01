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
    let name, height, mass, hair_color: String?
    let skin_color, eye_color, birth_year: String?
    let gender: String?
    let homeworld: String?
    let films, species, vehicles, starships: [String]?
    let created, edited: String?
    let url: String?
}

let defaultPerson = Person(name: nil, height: nil, mass: nil, hair_color: nil, skin_color: nil, eye_color: nil, birth_year: nil, gender: nil, homeworld: nil, films: nil, species: nil, vehicles: nil, starships: nil, created: nil, edited: nil, url: nil)

let defaultPeopleList = PeopleList(count: nil, next: nil, previous: nil, results: nil)
