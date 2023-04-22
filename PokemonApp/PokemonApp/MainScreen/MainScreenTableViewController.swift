//
//  MainScreenTableViewController.swift
//  PokemonApp
//
//  Created by Carolina on 19.04.23.
//

import UIKit

final class MainScreenTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: MainScreenTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: MainScreenTableViewCell.reuseIdentifier)
        tableView.rowHeight = 100.0
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reuseIdentifier, for: indexPath) as! MainScreenTableViewCell
        let inset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        cell.contentView.frame = cell.contentView.frame.inset(by: inset)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}
