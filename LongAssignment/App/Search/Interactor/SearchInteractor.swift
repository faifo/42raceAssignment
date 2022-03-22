//
//  SearchInteractor.swift
//  LongAssignment
//
//  Created by Solo on 20/03/2022.
//

import Foundation
protocol SearchInteractor {
    typealias FetchCompletion = (Result<BusinessResponse, Error>) -> Void
    func searchLocalBussiness(page : Int, term : String, completion: @escaping FetchCompletion)
}

struct SearchInteractorImpl: SearchInteractor {
    let service = NetworkServiceImpl<YelpApi>()
    func searchLocalBussiness(page : Int, term : String, completion: @escaping FetchCompletion) {
        service.request(.Search(["page" : page,
                                 "term" : term,
                                 "location" : "NY"
                                ])) { result in
            completion(result)
        }
    }
}

