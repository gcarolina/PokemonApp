//
//  MainScreenTableViewCell.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonName: UILabel!
    
    private let cellViewModel = MainScreenCellViewModel(pokemonName: "pikachu")
    static let reuseIdentifier = "MainScreenTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellViewModel.setUpUIForBorder(view: contentView)
    }
    
    override func layoutSubviews() {
        cellViewModel.setCornerRadius(view: contentView)
    }
}
