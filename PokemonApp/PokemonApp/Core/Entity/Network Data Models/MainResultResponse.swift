//
//  MainResultResponse.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import Foundation

struct MainResultResponse: Decodable {
    let count: Int
    let next: String
    let previous: String?
    let results: [ResultResponse]
}
