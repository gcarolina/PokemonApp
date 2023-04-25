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
    private let borderWidth: CGFloat = 9.5
    private let cornerRadius = 45.0
    
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
        view.layer.cornerRadius = CGFloat(cornerRadius)
        view.layer.masksToBounds = true
    }
    
    func setUpUIForBorder(view: UIView) {
        view.layer.borderColor = UIColor(red: 10/255, green: 40/255, blue: 95/255, alpha: 1).cgColor
        view.layer.borderWidth = borderWidth
    }
}
