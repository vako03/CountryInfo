//
//  SceneDelegate.swift
//  CountryInfo
//
//  Created by vako on 21.04.24.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        let hasLoggedInBefore = UserDefaults.standard.bool(forKey: "hasLoggedInBefore")
        let viewController = isLoggedIn && hasLoggedInBefore ? CountriesViewController() : LoginPageViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        
        window?.makeKeyAndVisible()
    }
}

