//
//  HomeViewController.swift
//  WedPlanner
//
//  Created by Jaqueline Botaro on 10/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        setupTabBar()
    }

    func setupTabBar() {
        let tabBarController = UITabBarController()

        let toDoController = UINavigationController(rootViewController: ToDoTableViewController())
        let doneController = UINavigationController(rootViewController: DoneTableViewController())

        tabBarController.setViewControllers([toDoController, doneController], animated: false)

        guard let tabBarItems = tabBarController.tabBar.items else {
            return
        }

        let titles = ["To Do", "Done"]
        let images = ["list.star", "checkmark"]

        for i in 0..<tabBarItems.count {
            tabBarItems[i].title = titles[i]
            tabBarItems[i].image = UIImage(systemName: images[i])
        }

        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.tabBar.barTintColor = .systemBackground
        tabBarController.tabBar.tintColor = .systemTeal
        tabBarController.tabBar.isTranslucent = true

        present(tabBarController, animated: true)
    }
}
