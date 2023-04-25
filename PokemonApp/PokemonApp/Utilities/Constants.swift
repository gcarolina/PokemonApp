//
//  Constants.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import Foundation

struct ConstantsForReuseIdentifier {
    static let reuseIdentifierForMainScreenTableViewCell = "MainScreenTableViewCell"
}

struct ConstantsForStoryboardsAndViewController {
    static let detailPokemonStoryboard = "DetailPokemonStoryboard"
    static let detailPokemonViewController = "DetailPokemonViewController"
    
    static let networkErrorStoryboard = "NetworkErrorStoryboard"
    static let networkErrorViewController = "NetworkErrorViewController"
}

struct ConstantsForImages {
    static let backImageName = "chevron.backward"
}

struct RequestURL {
    static let urlForListOfPokemons = "https://pokeapi.co/api/v2/pokemon"
}
