//
//  Transform.swift
//  APIService
//
//  Created by Simon on 2021/6/26.
//

import Foundation
import ObjectMapper

class DecimalTransform: TransformType {
    
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


class NSURLTransform: TransformType {
    typealias Object = NSURL
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> NSURL? {
        guard let string = value as? String else {
            return nil
        }
        return NSURL.init(string: string)
    }
    
    func transformToJSON(_ value: NSURL?) -> String? {
        guard let url = value else {
            return nil
        }
        return url.absoluteString
    }

}
class IntTransform: TransformType {

    public typealias Object = Int
    public typealias JSON = Any?
    public init() {}
    public func transformFromJSON(_ value: Any?) -> Int? {
        var result: Int?
        guard let json = value else {
            return result
        }
        /// 如果是数值类型，小数等，需要用NSNumber
        if json is NSNumber {
            result = (json as! NSNumber).intValue
        }
        if json is Int {
            result = (json as! Int)
        }
        if json is String {
            result = Int(json as! String)
        }
        return result
    }

    public func transformToJSON(_ value: Int?) -> Any?? {
        guard let object = value else {
            return nil
        }
        return String(object)
    }
}

class StringTransform: TransformType {

    public typealias Object = String
    public typealias JSON = Any?
    public init() {}
    public func transformFromJSON(_ value: Any?) -> String? {
        var result: String?
        guard let json = value else {
            return result
        }
        /// 如果是数值类型，小数等，需要用NSNumber
        if json is NSNumber {
            result = (json as! NSNumber).stringValue
        }
        if json is Int {
            result = String(json as! Int)
        }
        if json is Float {
            result = String(json as! Float)
        }
        if json is String {
            result = (json as! String)
        }
        return result
    }

    public func transformToJSON(_ value: String?) -> Any?? {
        guard let object = value else {
            return nil
        }
        return String(object)
    }
}

class NSNumberTransform: TransformType {
    public typealias Object = NSNumber
    public typealias JSON = Any?
    public init() {}
    public func transformFromJSON(_ value: Any?) -> NSNumber? {
        var result: NSNumber?
        guard let json = value else {
            return result
        }
        if json is Int {
            result = NSNumber(value: (json as! Int))
        }
        if json is Float {
            result = NSNumber(value: (json as! Float))
        }
        if json is Double {
            result = NSNumber(value: (json as! Double))
        }
        if json is String {
            result = NSNumber(value: Int(json as! String) ?? 0)
        }
        return result
    }

    public func transformToJSON(_ value: NSNumber?) -> Any?? {
        guard let object = value else {
            return nil
        }
        return object.stringValue
    }
}
