//
//  Observable+ObjectMapper.swift
//  HiNovelSwift
//
//  Created by long on 2020/12/25.
//

import Foundation
import Moya
import ObjectMapper
import SwiftyJSON

public extension Response {
    func mapObject<T: Mappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let json = jsonData as? [String: Any] else {
            throw APIError.responseSerializationException(.jsonSerializationFailed(nil))
        }
        let baseResponse = Mapper<BaseResponse>(context: context).map(JSON:json)
        guard let data = baseResponse?.data else {
            throw APIError.responseSerializationException(.dataNotFound)
        }
        guard let object = Mapper<T>(context: context).map(JSONString: (data.rawString())!) else {
            throw APIError.ResponseSerializationException.objectFailed
        }
        
        return object
    }

    func mapArray<T: Mappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let json = jsonData as? [String: Any] else {
            throw APIError.responseSerializationException(.jsonSerializationFailed(nil))
        }
        let baseResponse = Mapper<BaseResponse>(context: context).map(JSON:json)
        guard let data = baseResponse?.data else {
            throw APIError.responseSerializationException(.dataNotFound)
        }
        guard let array = Mapper<T>(context: context).mapArray(JSONObject: data.arrayObject) else {
            throw APIError.ResponseSerializationException.objectFailed
        }
        return array
    }
    
    func mapResponse<T: Mappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let json = jsonData as? [String: Any] else {
            throw APIError.responseSerializationException(.jsonSerializationFailed(nil))
        }
        guard let baseResponse = Mapper<BaseResponse>(context: context).map(JSON:json) else {
            throw APIError.responseSerializationException(.jsonSerializationFailed(nil))
        }
        return baseResponse as! T
    }
}
