//
//  YelpApi.swift
//  LongAssignment
//
//  Created by Solo on 20/03/2022.
//

import Foundation

enum YelpApi {
    case Search([String:Any])
}

let API_KEY = "ViWoBpXm18vf2Sm-NF6TyHp1P-DLc3KEaZxZHkbuvuakSM_nwyUEQ8ahsvkJTaozTKhERmvU5BaL_96A-qN6v6DWRclWVBNl_wUYkeeWKxOtuxoFhShE37e_aKs2YnYx"

extension YelpApi: EndPointType {
    var baseURL: URL {
        URL(string: "https://api.yelp.com/v3/")!
    }
    
    var path: String {
        switch self {
            case .Search:
                return "businesses/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
            case .Search:
                return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
            case .Search(let searchParams):
                return .requestParameters(bodyParameters: nil,
                                          bodyEncoding: .urlEncoding,
                                          urlParameters: searchParams)
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
            case .Search:
                return ["Authorization": "Bearer \(API_KEY)"]
        }
    }
}
