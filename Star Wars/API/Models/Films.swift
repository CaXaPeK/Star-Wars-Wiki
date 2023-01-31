// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let films = try? JSONDecoder().decode(Films.self, from: jsonData)

import Foundation

struct FilmList: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Film]?
}

struct Film: Codable {
    let title: String?
    let episodeID: Int?
    let openingCrawl, director, producer, releaseDate: String?
    let characters, planets, starships, vehicles: [String]?
    let species: [String]?
    let created, edited: String?
    let url: String?
}
