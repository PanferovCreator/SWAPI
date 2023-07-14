//
//  TabBarViewController.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 10/07/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let characters = createNavigation(
            with: "Characters",
            and: UIImage(systemName: "person.3")?.withTintColor(.yellow),
            vc: CharacterListViewController()
        )
        let ships = createNavigation(
            with: "Ships",
            and: UIImage(systemName: "airplane"),
            vc: ShipListViewController()
        )
        let planets = createNavigation(
            with: "Planets",
            and: UIImage(systemName: "globe"),
            vc: PlanetListViewController()
        )
        
        self.setViewControllers([characters, ships, planets], animated: true)
    }
}

private extension UITabBarController {
    func createNavigation(with title: String,
                          and image: UIImage?,
                          vc: UIViewController
    ) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        
        tabBar.tintColor = .yellow
        UITabBar.appearance().isTranslucent = false
        
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        navigation.viewControllers.first?.navigationItem.title = "SWAPI"
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.prefersLargeTitles = true
        navigation.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemYellow
        ]
        navigation.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemYellow
        ]

        return navigation
    }
}
