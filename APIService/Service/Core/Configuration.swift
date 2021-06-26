//
//  Configuration.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/12/25.
//

import Moya
import SwiftyJSON
import ObjectMapper

public struct BaseResponse: Mappable {
    var data :JSON?
    var errorCode: Int = 0
    var errorMsg: String? = ""
    var result: Int = 0

    public init?(map: Map) {}

    mutating public func mapping(map: Map) {
        data        <- map["data"]
        errorCode   <- map["errorCode"]
        errorMsg    <- map["errorMsg"]
        result      <- map["result"]
    }
    
    func mapObject<T: Mappable>(_ type: T.Type ) throws -> T {
        guard let object = Mapper<T>().map(JSONString: (data?.rawString())!) else {
            throw APIError.ResponseSerializationException.objectFailed
        }
        return object
    }
    
    func mapArray<T: Mappable>(_ type: T.Type) throws -> [T] {
        guard let array = Mapper<T>().mapArray(JSONObject: data?.arrayObject) else {
            throw APIError.ResponseSerializationException.objectFailed
        }
        return array
    }
    
    func mapType<T>(_ type: T.Type) throws -> T {
        guard let type = data?.object else {
            throw APIError.ResponseSerializationException.objectFailed
        }
        return type as! T
    }
}


public class Configuration {
    public static var `default`: Configuration = Configuration()
    
    public var addingHeaders: (TargetType) -> [String: String] = { _ in [:] }

    public var replacingTask: (TargetType) -> Task = { $0.task }
    
    /// 网络超时时间
    public var timeoutInterval: TimeInterval = 60
    
    /// 插件
    public var plugins: [PluginType] = [LoggerPlugin()]
    
    /// 能否打印 log
    public var logEnable: Bool = true
    
    public init() { }
}
