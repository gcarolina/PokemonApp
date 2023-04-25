//
//  MainScreenTableViewCell.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

final class MainScreenTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pokemonName: UILabel!
    
    // MARK: - let/var
    private let borderWidth: CGFloat = 9.5
    private let cornerRadius = 45.0

    var cellViewModel: MainScreenCellViewModelProtocol? {
        willSet(cellViewModel) {
            guard let cellViewModel = cellViewModel else { return }
            pokemonName.text = cellViewModel.name
        }
    }

    // MARK: - Life cycle
    override func layoutSubviews() {
        cellViewModel?.setCornerRadius(view: contentView)
        cellViewModel?.setUpUIForBorder(view: contentView)
    }
}
