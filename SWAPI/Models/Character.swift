//
//  Character.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 11/07/23.
//

import Foundation

struct Characters: Decodable {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [Character]
}

struct Character: Decodable {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: URL
    let starships: [URL]
    let url: URL

    var description: String {
        """
        gender: \(gender)
        height: \(height)
        mass: \(mass)
        hair color: \(hairColor)
        skin color: \(skinColor)
        eye color: \(eyeColor)
        birth year: \(birthYear)
        """
    }
}

struct Ships: Decodable {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [Ship]
}

struct Ship: Decodable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let hyperdriveRating: String
    let starshipClass: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let url: URL
    
    var description: String {
        """
        name: \(name)
        model: \(model)
        manufacturer: \(manufacturer)
        cost in credits: \(costInCredits)
        length: \(length)
        max atmosphering speed: \(maxAtmospheringSpeed)
        hyper dive rating: \(hyperdriveRating)
        starship class: \(starshipClass)
        crew: \(crew)
        passengers: \(passengers)
        cargo capacity: \(cargoCapacity)
        """
    }
}

struct Planets: Decodable {
    let count: Int
    let next: String?
    let pervious: String?
    var results: [Planet]
}

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let surfaceWater: String
    let population: String
    let url: URL
    
    var description: String {
        """
        name: \(name)
        rotation period: \(rotationPeriod)
        orbital period: \(orbitalPeriod)
        diameter: \(diameter)
        climate: \(climate)
        gravity: \(gravity)
        surface water: \(surfaceWater)
        population: \(population)
        """
    }
}
