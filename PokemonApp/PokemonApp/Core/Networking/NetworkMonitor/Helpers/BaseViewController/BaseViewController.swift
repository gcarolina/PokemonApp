//
//  BaseViewController.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import UIKit
import RealmSwift

class BaseViewController: UIViewController {
   
    // MARK: - let/var
    var baseViewModel: BaseProtocol?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewModel = BaseViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewModel?.startReachabilityNotifier(
            onReachable: {
                self.view.window?.rootViewController?.dismiss(animated: true)
            },
            onUnreachable: {
                let storyboard = UIStoryboard(name: ConstantsForStoryboardsAndViewController.networkErrorStoryboard, bundle: nil)
                guard let networkVC = storyboard.instantiateViewController(withIdentifier: ConstantsForStoryboardsAndViewController.networkErrorViewController) as? NetworkErrorViewController else { return }
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
