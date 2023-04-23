//
//  MainScreenTableViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 22.04.23.
//

import UIKit

protocol MainScreenTableViewProtocol {
    var rowHeight: Double { get }
    func numberOfRows() -> Int
    func pokemonName(at index: Int) -> String
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelProtocol?
    func getListOfPokemons(completion: @escaping (Result<Void, Error>) -> Void)
    
    func selectRow(atIndexPath indexPath: IndexPath)
}

final class MainScreenTableViewModel: MainScreenTableViewProtocol {
    var mainResultResponse: MainResultResponse?
    private var selectedIndexPath: IndexPath?
    var rowHeight = 100.0
    
    func numberOfRows() -> Int {
        mainResultResponse?.results.count ?? 0
    }
    
    func pokemonName(at index: Int) -> String {
        return mainResultResponse?.results[index].name ?? ""
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelProtocol? {
        guard let pokemon = mainResultResponse?.results[indexPath.row] else { return nil }
        return MainScreenCellViewModel(pokemon: pokemon)
    }
    
    func getListOfPokemons(completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkService.getPokemons { [weak self] result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self?.mainResultResponse = pokemons
                    completion(.success(()))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
