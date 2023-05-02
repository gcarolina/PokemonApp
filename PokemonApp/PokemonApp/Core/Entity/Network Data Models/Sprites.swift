//
//  Sprites.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import Foundation

struct Sprites: Decodable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
