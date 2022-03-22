//
//  Bussiness.swift
//  LongAssignment
//
//  Created by Solo on 22/03/2022.
//

import Foundation

struct BusinessResponse : Decodable {
    enum CodingKeys: CodingKey {
        case businesses
    }
    
    var businesses : [Business] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.businesses = try container.decode([Business].self, forKey: .businesses)

    }
}

struct Business : Decodable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case image_url
        case rating
        case distance
    }
    
    var id : String
    var name : String
    var image_url : String
    var rating : Float
    var distance : Float
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image_url = try container.decode(String.self, forKey: .image_url)
        self.rating = try container.decode(Float.self, forKey: .rating)
        self.distance = try container.decode(Float.self, forKey: .distance)

    }
    
    
}
