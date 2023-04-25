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
    
    var pokemonCharacteristics: PokemonCharacteristics?
    private var pokemonUrl: String?
        
    init(pokemonUrl: String) {
        self.pokemonUrl = pokemonUrl
    }

    var name: String { pokemonCharacteristics?.name ?? "" }
    var height: String { String(describing: "\((pokemonCharacteristics?.height ?? .zero) * 10) cm") }
    var weight: String { String(describing: "\((pokemonCharacteristics?.weight ?? .zero) / 10) kg") }
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
        guard let image = pokemonCharacteristics?.sprites.front_default else { return }
        NetworkService.getPhoto(imageURL: image) { image, error in
            completion(image)
        }
    }
}
