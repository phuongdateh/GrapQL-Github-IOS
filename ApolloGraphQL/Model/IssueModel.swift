//
//  IssueModel.swift
//  ApolloGraphQL
//
//  Created by DoanDuyPhuong on 8/5/20.
//  Copyright © 2020 prox.com. All rights reserved.
//

import Foundation
import ObjectMapper

class IssueModel: Mappable {
    var node: IssueNodeModel?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        node <- map["node"]
    }
}
