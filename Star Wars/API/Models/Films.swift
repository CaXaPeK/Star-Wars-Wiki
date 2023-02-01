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
    let episode_id: Int?
    let opening_crawl, director, producer, release_date: String?
    let characters, planets, starships, vehicles: [String]?
    let species: [String]?
    let created, edited: String?
    let url: String?
}

let defaultFilm = Film(title: nil, episode_id: nil, opening_crawl: nil, director: nil, producer: nil, release_date: nil, characters: nil, planets: nil, starships: nil, vehicles: nil, species: nil, created: nil, edited: nil, url: nil)

let defaultFilmList = FilmList(count: nil, next: nil, previous: nil, results: nil)
