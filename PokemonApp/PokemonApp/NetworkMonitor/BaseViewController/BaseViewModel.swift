//
//  BaseViewModel.swift
//  PokemonApp
//
//  Created by Carolina on 24.04.23.
//

import UIKit
import Reachability

enum ReachabilityConnection: String {
    case wifi = "Reachable via WiFi"
    case cellular = "Reachable via Cellular"
    case notReachable = "Not reachable"
    case unableNotifier = "Unable to start notifier"
}

protocol BaseProtocol {
    func startReachabilityNotifier(onReachable: @escaping () -> Void, onUnreachable: @escaping () -> Void, onError: @escaping (String) -> Void)
    func stopReachabilityNotifier()
}

class BaseViewModel: BaseProtocol {
    let reachability = try! Reachability()
    
    func startReachabilityNotifier(onReachable: @escaping () -> Void, onUnreachable: @escaping () -> Void, onError: @escaping (String) -> Void) {
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print(ReachabilityConnection.wifi.rawValue)
                } else {
                    print(ReachabilityConnection.cellular.rawValue)
                }
                onReachable()
            }
            self.reachability.whenUnreachable = { _ in
                print(ReachabilityConnection.notReachable.rawValue)
                onUnreachable()
            }
            do {
                try self.reachability.startNotifier()
            } catch {
                print(ReachabilityConnection.unableNotifier.rawValue)
                onError(ReachabilityConnection.unableNotifier.rawValue)
            }
        }
    }
    
    func stopReachabilityNotifier() {
        reachability.stopNotifier()
    }
}
