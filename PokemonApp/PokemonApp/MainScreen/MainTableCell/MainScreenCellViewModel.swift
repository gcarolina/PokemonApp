//
//  MainScreenCellViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 22.04.23.
//

import UIKit

final class MainScreenCellViewModel {
    private let pokemonName: String
    private let borderWidth: CGFloat = 4
    private let cornerRadius = 30.0
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
    }
    
    func configureCell(_ cell: MainScreenTableViewCell) {
        cell.pokemonName.text = pokemonName
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
