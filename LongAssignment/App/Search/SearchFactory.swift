//
//  SearchFactory.swift
//  LongAssignment
//
//  Created by Solo on 23/03/2022.
//

import UIKit

struct SearchFactory {
    
    static func make(networkCheckService: NetworkCheckService) -> UIViewController {
        
        let interactor = SearchInteractorImpl()
        
        let respository = SearchRepositoryImpl(interactor: interactor,
                                                networkCheck: networkCheckService)
        
        let viewModel = SearchViewModelImpl(resository: respository)
        
        let viewController = SearchViewController.instantiate(from: .main)
        viewController.viewModel = viewModel
        
        viewModel.delegate = viewController
        
        return viewController
    }
}
