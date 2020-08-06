//
//  PersonModel.swift
//  ApolloGraphQL
//
//  Created by DoanDuyPhuong on 8/6/20.
//  Copyright © 2020 prox.com. All rights reserved.
//

import Foundation
import ObjectMapper

class PersonModel: Mappable {
    var id: String?
    var username: String?
    var resourcePath: String?
    var url: String?
    var avatarUrl: String?
    
    required convenience init?(map: Map) {
        self.init()
        if let id = map.JSON["id"] as? String {
            self.id = id
        }
    }
    
    func mapping(map: Map) {
        username <- map["login"]
        avatarUrl <- map["avatarUrl"]
        url <- map["url"]
        resourcePath <- map["resourcePath"]
    }
}
