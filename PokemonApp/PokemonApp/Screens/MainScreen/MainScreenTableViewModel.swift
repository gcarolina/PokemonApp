//
//  MainScreenTableViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

protocol MainScreenTableViewProtocol {
    var rowHeight: Double { get }
    func numberOfRows() -> Int
    func pokemonName(at index: Int) -> String
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelProtocol?
    func getListOfPokemons(page: Int, pageSize: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func loadDataFromDatabase()
    
    func selectRow(atIndexPath indexPath: IndexPath)
    func viewModelForSelectedRow(networkService: NetworkService) -> DetailPokemonViewProtocol?
}

final class MainScreenTableViewModel: MainScreenTableViewProtocol {
    
    var mainResultResponse: MainResultResponse?
    var dataSource: [ResultResponse] = []
    private var selectedIndexPath: IndexPath?
    let rowHeight = MainScreenConstants.rowHeight
    
    func numberOfRows() -> Int {
        mainResultResponse?.results.count ?? .zero
    }
    
    func pokemonName(at index: Int) -> String {
        return mainResultResponse?.results[index].name ?? ""
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainScreenCellViewModelProtocol? {
        guard let pokemon = mainResultResponse?.results[indexPath.row] else { return nil }
        return MainScreenCellViewModel(pokemon: pokemon)
    }
    
    func getListOfPokemons(page: Int, pageSize: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        NetworkService.getPokemons(page: page, pageSize: pageSize) { [weak self] result in
            switch result {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    if page == 1 {
                        self?.mainResultResponse = pokemons
                    } else {
                        self?.mainResultResponse?.results.append(contentsOf: pokemons.results)
                    }
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
    
    func viewModelForSelectedRow(networkService: NetworkService) -> DetailPokemonViewProtocol? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        guard let pokemonURL = mainResultResponse?.results[selectedIndexPath.row].url else { return nil }
        return DetailPokemonViewModel(networkService: networkService, pokemonUrl: pokemonURL)
    }
    
    func loadDataFromDatabase() {
        let mainResultResponseObjects = StorageManager.getAllPokemons()
        var mainResultResponses: [MainResultResponse] = []
        mainResultResponseObjects.forEach { mainResultResponseObject in
            let mainResultResponse = mainResultResponseObject.toMainResultResponse()
            mainResultResponses.append(mainResultResponse)
        }
        dataSource = mainResultResponses.last?.results ?? []
    }
}
