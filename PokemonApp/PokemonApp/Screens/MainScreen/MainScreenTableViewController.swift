//
//  MainScreenTableViewController.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit
import RealmSwift

final class MainScreenTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - let/var
    private var viewModel: MainScreenTableViewProtocol?
    var mainResultResponse: MainResultResponse?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenTableViewModel()
        let cellNib = UINib(nibName: ConstantsForReuseIdentifier.reuseIdentifierForMainScreenTableViewCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: ConstantsForReuseIdentifier.reuseIdentifierForMainScreenTableViewCell)
        getAllPokemons()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsForReuseIdentifier.reuseIdentifierForMainScreenTableViewCell, for: indexPath) as? MainScreenTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.cellViewModel = cellViewModel
        
        return tableViewCell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel?.rowHeight ?? .zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        
        let storyboard = UIStoryboard(name: ConstantsForStoryboardsAndViewController.detailPokemonStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: ConstantsForStoryboardsAndViewController.detailPokemonViewController) as? DetailPokemonViewController else { return }
        
        let cacheManager = CacheManager(memoryCapacity: 100_000_000, preferredMemoryUsageAfterPurge: 60_000_000)
        let networkService = NetworkService(cacheManager: cacheManager)
            
        vc.detailViewModel = viewModel.viewModelForSelectedRow(networkService: networkService)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel?.numberOfRows() ?? .zero) - MainScreenConstants.lastRowIndex {
            let isConnectedToInternet = baseViewModel?.reachability.connection ?? .unavailable != .unavailable
            if isConnectedToInternet {
                loadMoreData()
            }
        }
    }

    // MARK: - Private functions
    func getAllPokemons() {
        viewModel?.getListOfPokemons(page: MainScreenConstants.currentPage, pageSize: MainScreenConstants.pageSize) { [weak self] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                guard let realm = try? Realm() else { return }
                
                let mainResultResponseObjects = realm.objects(MainResultResponseObject.self)
                mainResultResponseObjects.forEach { mainResultResponseObject in
                    _ = mainResultResponseObject.toMainResultResponse()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    private func loadMoreData() {
        MainScreenConstants.currentPage += MainScreenConstants.incrementBy
        getAllPokemons()
    }
}
