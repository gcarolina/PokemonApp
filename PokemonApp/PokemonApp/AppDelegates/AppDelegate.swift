//
//  AppDelegate.swift
//  PokemonApp
//
//  Created by Carolina on 18.04.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let navBarTintColor = UIColor(named: NavigationBarColor.navigationBarTintColor.rawValue) {
            UINavigationBar.appearance().barTintColor = navBarTintColor
        }
        
        if let navBarTitleTextColor = UIColor(named: NavigationBarColor.navigationBarTitleTextColor.rawValue) {
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : navBarTitleTextColor]
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

