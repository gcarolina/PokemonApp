//
//  ReachabilityConnection.swift
//  PokemonApp
//
//  Created by Carolina on 25.04.23.
//

import Foundation

enum ReachabilityConnection: String {
    case wifi = "Reachable via WiFi"
    case cellular = "Reachable via Cellular"
    case notReachable = "Not reachable"
    case unableNotifier = "Unable to start notifier"
}
