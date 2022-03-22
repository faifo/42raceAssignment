//
//  SearchRepository.swift
//  LongAssignment
//
//  Created by Solo on 22/03/2022.
//

import Foundation
import Network

protocol SearchRepository {
    typealias FetchCompletion = (Result<[Business], Error>) -> Void
    var count: Int { get }
    
    func searchBusiness(page: Int, term: String, completion: @escaping FetchCompletion)
}

final class SearchRepositoryImpl: SearchRepository {
    
    private let interactor: SearchInteractor
    private let networkCheck: NetworkCheckService
    
    var count = Int.max
    var networkAvailable: Bool!
    
    init(interactor: SearchInteractor,
         networkCheck: NetworkCheckService) {
        self.interactor = interactor
        self.networkCheck = networkCheck
        
        networkCheck.addObserver(observer: self)
        networkAvailable = networkCheck.currentStatus == .satisfied
    }
    
    func searchBusiness(page: Int, term: String, completion: @escaping FetchCompletion) {
        if networkAvailable {
            interactorFetch(page: page, term: term, completion: completion)
        }
    }
    
    func interactorFetch(page: Int, term : String,  completion: @escaping FetchCompletion) {
        interactor.searchLocalBussiness(page: page, term: term) { [weak self] result in
            switch result {
                case .success(let response):
                    do {
                        completion(.success(response.businesses))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    deinit {
        networkCheck.removeObserver(observer: self)
    }
    
}

/*
 Due to bug in Simulator API, NWPath.Status will never return .satisfied while testing on simulator,
 If network was turned off and then turned on.
 */
extension SearchRepositoryImpl: NetworkCheckObserver {
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            networkAvailable = true
        }else if status == .unsatisfied {
            networkAvailable = false
        }
    }
}
