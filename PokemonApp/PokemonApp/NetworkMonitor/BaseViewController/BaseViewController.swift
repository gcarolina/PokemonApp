//
//  BaseViewController.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
    var baseViewModel: BaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewModel = BaseViewModel()
        DispatchQueue.main.async {
            let realm = try! Realm()
            let allPokemons = realm.objects(MainResultResponseObject.self)
            for pokemon in allPokemons {
                print(pokemon.count)
                print(pokemon.next)
                print(pokemon.previous)
                for result in pokemon.results {
                    print(result.name)
                    print(result.url)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewModel?.startReachabilityNotifier(
            onReachable: {
                self.view.window?.rootViewController?.dismiss(animated: true)
            },
            onUnreachable: {
                let storyboard = UIStoryboard(name: NetworkErrorViewController.networkErrorStoryboard, bundle: nil)
                guard let networkVC = storyboard.instantiateViewController(withIdentifier: NetworkErrorViewController.networkErrorViewController) as? NetworkErrorViewController else { return }
                self.present(networkVC, animated: true)
            },
            onError: { error in
                print(error)
            }
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        baseViewModel?.stopReachabilityNotifier()
    }
}
