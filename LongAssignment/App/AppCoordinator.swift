//
//  AppCoordinator.swift
//  LongAssignment
//
//  Created by Solo on 23/03/2022.
//

import UIKit
final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private let networkService: NetworkCheckService
    
    init(window: UIWindow,
         networkCheckService: NetworkCheckService) {
        self.window = window
        self.networkService = networkCheckService
        navigationController = UINavigationController()
    }
    
    func start() {
        let viewController = SearchFactory.make(networkCheckService: networkService)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
