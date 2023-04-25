//
//  NetworkError.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
