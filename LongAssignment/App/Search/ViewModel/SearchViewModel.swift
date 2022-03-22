//
//  SearchViewModel.swift
//  LongAssignment
//
//  Created by Solo on 22/03/2022.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reloadData(state: ViewControllerState)
}

protocol SearchViewModel {
    var businesses: [BusinessViewData] { get }
    func loadData(term : String)
}

final class SearchViewModelImpl : SearchViewModel {
    
    private let repository: SearchRepository
    
    weak var delegate: SearchViewModelDelegate?
    
    var businesses: [BusinessViewData] = [BusinessViewData]()
    var currentPage = 1
    
    init(resository: SearchRepository) {
        self.repository = resository
    }
    
    func loadData(term : String) {
        delegate?.reloadData(state: .loading)
        repository.searchBusiness(page: currentPage, term: term) { [weak self] result in
            switch result {
                case .success(let response):
                    self?.parse(response)
                    self?.delegate?.reloadData(state: .success)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.delegate?.reloadData(state: .error)
            }
        }
    }
}

private extension SearchViewModelImpl {
    
    func parse(_ response: [Business]) {
        let viewDataObjects = makeViewData(businesses: response)
        viewDataObjects.forEach {
            if !businesses.contains($0) {
                businesses.append($0)
            }
        }
        
        currentPage += 1
    }
    
    func makeViewData(businesses: [Business]) -> [BusinessViewData] {
        var viewDatas = [BusinessViewData]()
     
        // sort by distance -> rating
        let sorted = businesses.sorted { (lhs, rhs) in
            if lhs.distance == rhs.distance { // <1>
                return lhs.rating > rhs.rating
            }
            
            return lhs.distance > rhs.distance // <2>
        }
        
        sorted.forEach {
            if let viewData = map(model: $0) {
                viewDatas.append(viewData)
            }
        }
        return viewDatas
    }
    
    func map(model: Business) -> BusinessViewData? {
        return .init(imageUrl: model.image_url, name: model.name, id: model.id, rating: model.rating, distance: model.distance)
    }
    
}

