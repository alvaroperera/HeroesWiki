//
//  SuperHeroAPIHelper.swift
//  HeroesWiki
//
//  Created by Álvaro Perera on 18/12/24.
//
import Foundation

class SuperHeroAPIHelper {
    
    static let apiKeySetting: String = "6c268a0c8e2043dffcc85cdc5749bf13"
    
    static func getHeroesByName(name: String,
                                baseUrl: String = "https://superheroapi.com/api/",
                                apiKey: String = apiKeySetting) async throws -> [Hero] {
        
        let petition = URL(string: "\(baseUrl)\(apiKey)/search/\(name)")!
        
        let (data, _) = try await URLSession.shared.data(from: petition)
        
        let result = try JSONDecoder().decode(HeroResponse.self, from: data)
        
        return result.results
    }
    
    static func getHeroById(id: String,
                            baseUrl: String = "https://superheroapi.com/api/",
                            apiKey: String = apiKeySetting) async throws -> Hero {
        
        let petition = URL(string: "\(baseUrl)\(apiKey)/\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: petition)
        
        let result = try JSONDecoder().decode(Hero.self, from: data)
        
        return result
    }
}
