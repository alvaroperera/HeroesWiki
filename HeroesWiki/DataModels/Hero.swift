//
//  Hero.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//

import Foundation

struct Hero: Codable {
    let id: String
    let name: String
    let image: Image
    let biography: Biography
    let powerstats: Powerstats
}

struct HeroResponse: Codable {
    let results: [Hero]
}

struct Biography: Codable {
    let realName: String
    let publisher: String
    let alignment: String
    let placeOfBirth: String
    
    private enum CodingKeys : String, CodingKey {
        case alignment, publisher
        case realName = "full-name"
        case placeOfBirth = "place-of-birth"
    }
}

struct Powerstats: Codable {
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}

struct Image: Codable {
    let url: String
}
