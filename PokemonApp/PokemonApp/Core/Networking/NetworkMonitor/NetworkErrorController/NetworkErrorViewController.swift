//
//  NetworkErrorViewController.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import UIKit

final class NetworkErrorViewController: UIViewController, UIGestureRecognizerDelegate {
    static let networkErrorStoryboard = "NetworkErrorStoryboard"
    static let networkErrorViewController = "NetworkErrorViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
    }
}
