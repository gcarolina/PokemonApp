//
//  MainScreenCellViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

protocol MainScreenCellViewModelProtocol {
    var name: String { get }
    var url: String { get }
    func setCornerRadius(view: UIView)
    func setUpUIForBorder(view: UIView)
}

final class MainScreenCellViewModel: MainScreenCellViewModelProtocol {
   
    private var pokemon: ResultResponse
    
    init(pokemon: ResultResponse) {
        self.pokemon = pokemon
    }
    
    var name: String {
        pokemon.name
    }
    
    var url: String {
        pokemon.url
    }
    
    func setCornerRadius(view: UIView) {
        view.layer.cornerRadius = CGFloat(MainScreenConstants.cornerRadius)
        view.layer.masksToBounds = true
    }
    
    func setUpUIForBorder(view: UIView) {
        view.layer.borderColor = MainScreenConstants.borderColor
        view.layer.borderWidth = MainScreenConstants.borderWidth
    }
}
