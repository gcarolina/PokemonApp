//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

final class DetailPokemonViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var pokemonImage: UIImageView!
    @IBOutlet private weak var nameOfPokemon: UILabel!
    @IBOutlet private weak var height: UILabel!
    @IBOutlet private weak var weight: UILabel!
    @IBOutlet private weak var types: UILabel!
    
    // MARK: - let/var
    var detailViewModel: DetailPokemonViewProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItem()
        getInfoOfPokemon()
    }
    
    // MARK: - Private functions
    private func createButton(imageName: String, tintColor: UIColor, backgroundColor: UIColor, target: Any?, action: Selector?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = tintColor
        button.addTarget(target, action: #selector(backButtonTapped), for: .touchUpInside)
        button.frame = DetailScreenConstants.buttonFrame
        button.layer.cornerRadius = DetailScreenConstants.buttonCornerRadius
        button.backgroundColor = backgroundColor
        return button
    }
    
    private func createBarButtonItem() {
        let backButton = createButton(imageName: ConstantsForImages.backImageName,
                                      tintColor: DetailScreenConstants.buttonTintColor,
                                      backgroundColor: DetailScreenConstants.buttonBackgroundColor,
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
                self?.updateUI()
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert(titleForAlert: TextForAlert.titleForAlert.rawValue, messageForAlert: TextForAlert.messageForAlert.rawValue, doneButtonNameForAlert: TextForAlert.doneButtonNameForAlert.rawValue)
                }
            }
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.nameOfPokemon.text = self?.detailViewModel?.name
            self?.height.text = self?.detailViewModel?.height
            self?.weight.text = self?.detailViewModel?.weight
            self?.getPokemonTypes()
            
            self?.detailViewModel?.getImage(completion: { [weak self] image in
                DispatchQueue.main.async {
                    self?.pokemonImage.image = image
                }
            })
        }
    }
    
    private func getPokemonTypes() {
        var typesNames = ""
        if let types = self.detailViewModel?.types {
            for type in types {
                typesNames += "\(type.type.name), "
            }
            typesNames = String(typesNames.dropLast(DetailScreenConstants.numberOfCharsToRemove))
        }
        self.types.text = typesNames
    }
}
