//
//  DetailPokemonViewController.swift
//  PokemonApp
//
//  Created by Carolina on 23.04.23.
//

import UIKit

final class DetailPokemonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButtonItems()
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
    
    private func createBarButtonItems() {
        let backButton = createButton(imageName: "chevron.backward",
                                      tintColor: UIColor(red: 213/255, green: 161/255, blue: 0, alpha: 1),
                                      backgroundColor: UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1),
                                      target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
