//
//  Transform.swift
//  APIService
//
//  Created by Simon on 2021/6/26.
//

import Foundation
import ObjectMapper

open class DecimalTransform: TransformType {
    
    public typealias Object = Decimal
    
    public typealias JSON = Decimal
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Decimal? {
        if let number = value as? NSNumber {
            return Decimal(string: number.description)
        }
        if let number = value as? String {
            return Decimal(string: number)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Decimal?) -> Decimal? {
        return value
    }

}
