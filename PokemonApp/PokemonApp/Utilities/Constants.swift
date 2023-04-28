//
//  Constants.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import UIKit

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

struct MainScreenConstants {
    static let rowHeight = 100.0
    static let cornerRadius = 45.0
    static let borderWidth: CGFloat = 9.5
    static let borderColor = UIColor(red: 10/255, green: 40/255, blue: 95/255, alpha: 1).cgColor
}

struct DetailScreenConstants {
    static let buttonCornerRadius: CGFloat = 20
    static let buttonFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
    static let buttonTintColor = UIColor(red: 0, green: 73/255, blue: 190/255, alpha: 1)
    static let buttonBackgroundColor = UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1)
    static let numberOfCharsToRemove = 2
    static let conversionFactor: Double = 10
}
