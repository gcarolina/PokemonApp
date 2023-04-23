//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

final class DetailPokemonViewController: UIViewController {
    
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var nameOfPokemon: UILabel!
    @IBOutlet private weak var height: UILabel!
    @IBOutlet private weak var weight: UILabel!
    @IBOutlet private weak var types: UILabel!
    
    var detailViewModel: DetailPokemonViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
        getInfoOfPokemon()
    }
    
    private func createButton(imageName: String, tintColor: UIColor, backgroundColor: UIColor, target: Any?, action: Selector?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = tintColor
        button.addTarget(target, action: #selector(backButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.layer.cornerRadius = 20
        button.backgroundColor = backgroundColor
        return button
    }
    
    private func createBarButtonItem() {
        let backButton = createButton(imageName: DetailPokemonViewModel.backImageName,
                                      tintColor: UIColor(red: 0, green: 73/255, blue: 190/255, alpha: 1),
                                      backgroundColor: UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1),
                                      target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func getInfoOfPokemon() {
        detailViewModel?.getPokemonCharacteristics { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.nameOfPokemon.text = self?.detailViewModel?.name
                    self?.height.text = self?.detailViewModel?.height
                    self?.weight.text = self?.detailViewModel?.weight
                    self?.getPokemonTypes()
                    
                    self?.detailViewModel?.getImage { [weak self] image in
                        DispatchQueue.main.async {
                            self?.pokemonImage.image = image
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPokemonTypes() {
        var typesNames = ""
        if let types = self.detailViewModel?.types {
            for type in types {
                typesNames += "\(type.type.name), "
            }
            typesNames = String(typesNames.dropLast(2))
        }
        self.types.text = typesNames
    }
}
