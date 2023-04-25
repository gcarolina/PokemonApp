//
//  PokemonCharacteristics.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import Foundation

struct PokemonCharacteristics: Decodable {
    let name: String
    let height: Double
    let weight: Double
    let sprites: Sprites
    let types: [Types]
}
