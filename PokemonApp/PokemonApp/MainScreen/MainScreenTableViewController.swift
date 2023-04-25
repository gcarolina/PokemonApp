//
//  MainScreenTableViewController.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

final class MainScreenTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var tableView: UITableView!
    private var viewModel: MainScreenTableViewProtocol?
    var mainResultResponse: MainResultResponse?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainScreenTableViewModel()
        let cellNib = UINib(nibName: MainScreenTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainScreenTableViewCell.reuseIdentifier)
        getAllPokemons()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reuseIdentifier, for: indexPath) as? MainScreenTableViewCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.cellViewModel = cellViewModel
        return tableViewCell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel?.rowHeight ?? 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectRow(atIndexPath: indexPath)
        let storyboard = UIStoryboard(name: DetailPokemonViewModel.detailPokemonStoryboard, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: DetailPokemonViewModel.detailPokemonViewController) as? DetailPokemonViewController else { return }
        vc.detailViewModel = viewModel.viewModelForSelectedRow()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Private functions
    private func getAllPokemons() {
        viewModel?.getListOfPokemons { [weak self] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.viewModel?.loadDataFromDatabase()
                    self?.tableView.reloadData()
                    let alert = UIAlertController(title: TextForAlert.titleForAlert, message: TextForAlert.messageForAlert, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: TextForAlert.doneButtonNameForAlert, style: .default))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
