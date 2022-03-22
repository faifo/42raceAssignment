//
//  ModelConfigurable.swift
//  LongAssignment
//
//  Created by Solo on 23/03/2022.
//

import Foundation

protocol ModelConfigurable {
    associatedtype Model
    
    func configure(with model: Model)
}
