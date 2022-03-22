//
//  AppDelegate.swift
//  LongAssignment
//
//  Created by Solo on 20/03/2022.
//

import Foundation

public protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
