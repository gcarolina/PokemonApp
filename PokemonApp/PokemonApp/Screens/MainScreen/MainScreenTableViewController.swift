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
            case .failure(_):
                DispatchQueue.main.async {
                    self?.viewModel?.loadDataFromDatabase()
                    self?.tableView.reloadData()
                    let alert = UIAlertController(title: TextForAlert.titleForAlert.rawValue, message: TextForAlert.messageForAlert.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: TextForAlert.doneButtonNameForAlert.rawValue, style: .default))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
