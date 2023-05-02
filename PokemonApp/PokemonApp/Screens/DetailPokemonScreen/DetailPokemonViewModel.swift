//
//  DetailPokemonViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

protocol DetailPokemonViewProtocol {
    var name: String { get }
    var height: String { get }
    var weight: String { get }
    var types: [Types] { get }
    func getPokemonCharacteristics(completion: @escaping (Result<Void, Error>) -> Void)
    func getImage(completion: @escaping (UIImage?) -> Void)
}

final class DetailPokemonViewModel: DetailPokemonViewProtocol {
    
    let networkService: NetworkService
    var pokemonCharacteristics: PokemonCharacteristics?
    private var pokemonUrl: String?
    
    init(networkService: NetworkService, pokemonUrl: String) {
        self.networkService = networkService
        self.pokemonUrl = pokemonUrl
    }

    var name: String { pokemonCharacteristics?.name ?? "" }
    var height: String { String(describing: "\((pokemonCharacteristics?.height ?? .zero) * DetailScreenConstants.conversionFactor) \(UnitsOfMeasurement.centimeters.rawValue)") }
    var weight: String { String(describing: "\((pokemonCharacteristics?.weight ?? .zero) / DetailScreenConstants.conversionFactor) \(UnitsOfMeasurement.kilograms.rawValue)") }
    var types: [Types] { pokemonCharacteristics?.types ?? [] }
    
    func getPokemonCharacteristics(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let pokemonUrl = pokemonUrl else { return }
        NetworkService.getPokemonInfo(pokemonUrl: pokemonUrl) { [weak self] result in
            switch result {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self?.pokemonCharacteristics = pokemon
                    completion(.success(()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        guard let image = pokemonCharacteristics?.sprites.frontDefault else { return }
        networkService.getPhoto(imageURL: image) { image, error in
            completion(image)
        }
    }
}
