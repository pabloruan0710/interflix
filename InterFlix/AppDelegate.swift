//
//  AppDelegate.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UITabBar.appearance().tintColor = UIColor.systemPink
        let rootView = RootTabBarViewController()
        rootView.setViewControllers([
            makeInicioViewController(),
            makePopularesViewController()
        ], animated: false)
        
        window?.rootViewController = rootView
        window?.makeKeyAndVisible()
        return true
    }
    
    private func makeInicioViewController() -> UIViewController {
        let viewController = InicioViewController(title: "InterFlix")
        viewController.tabBarItem = UITabBarItem(title: Tabs.inicio.title, image: Tabs.inicio.image, tag: Tabs.inicio.rawValue)
        return viewController
    }
    
    private func makePopularesViewController() -> UIViewController {
        let viewController = PopularesViewController()
        viewController.tabBarItem = UITabBarItem(title: Tabs.populares.title, image: Tabs.populares.image, tag: Tabs.populares.rawValue)
        return viewController
    }
}

