//
//  Mappable+ObjectMapper.swift
//  APIService
//
//  Created by Simon on 2021/6/26.
//

import Foundation
import ObjectMapper

public extension Mappable {
    init() {
        self.init(map: Map(mappingType: .fromJSON, JSON: [:]))!
    }
}
