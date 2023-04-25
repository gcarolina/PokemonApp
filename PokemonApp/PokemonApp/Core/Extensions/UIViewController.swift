//
//  UIViewController.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import UIKit

extension UIViewController {
    func showAlert(titleForAlert: String, messageForAlert: String, doneButtonNameForAlert: String) {
        let alert = UIAlertController(title: titleForAlert, message: messageForAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: doneButtonNameForAlert, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
