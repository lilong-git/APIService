//
//  APITargetType.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/10/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import ObjectMapper
import RxSwift
import CryptoSwift
import DeviceKit

/// 请求头配置
public func requestHeaders() -> [String : String]? {

    var headers = [String : String]()
    headers["timestamp"] = DateHelper.fetchCurrentTimestamp()
    headers["lang"] = LanguageManager.default.currentAppLanguage.rawValue
    headers["appType"] = AppInfoHelper.systemModel().lowercased()
    headers["appVersion"] = AppInfoHelper.appVersion()
    headers["osType"] = "0"
    headers["osVersion"] = AppInfoHelper.systemVersion()
    headers["osUuid"] = AppInfoHelper.deviceUUID()
    headers["phoneBrand"] = "Apple"
    headers["phoneType"] = AppInfoHelper.machineModel()
    headers["phoneOsVersion"] = AppInfoHelper.systemVersion()
    headers["utc"] = String(DateHelper.utc())
    
    let sign = try? HMAC(key:"sdasdsadasdadasdasdasdkjbasbd".bytes,variant: .md5).authenticate(signSort(headers).bytes).toHexString()
    headers["sign"] = sign
    headers["userToken"] = AppInfoHelper.deviceUUID()
    
    return headers
}


/// 签名
private func signSort(_ headers:[String: String]) -> String {
    let keys = ["timestamp",
               "lang",
               "appType",
               "appVersion",
               "osType",
               "osVersion",
               "osUuid",
               "phoneBrand",
               "phoneType",
               "phoneOsVersion"]
    
    let signText = NSMutableString()
    for item in keys {
        signText.appendFormat("%@=%@&", item,headers[item]!)
    }
    return String(signText)
}


public struct Headers {
    var timestamp: String = DateHelper.fetchCurrentTimestamp()
    var lang: String = LanguageManager.default.currentAppLanguage.rawValue
    var appType: String = AppInfoHelper.systemModel().lowercased()
    var appVersion: String = AppInfoHelper.appVersion()
    var osType: String = "0"
    var osVersion: String = AppInfoHelper.systemVersion()
    var osUuid: String = AppInfoHelper.deviceUUID()
    var phoneBrand: String = "Apple"
    var phoneType: String = AppInfoHelper.machineModel()
    var phoneOsVersion: String = AppInfoHelper.systemVersion()
    var utc: String = String(DateHelper.utc())
    var sign: String = ""
    var userToken: String = ""
    
    
}

public protocol APITargetType : TargetType {
    /// 语言环境
    var language: AppLanguage { get }
    /// 请求参数
    var parameters: [String : Any] { get }
}


extension APITargetType {
    
    public var language: AppLanguage {
        return LanguageManager.default.currentAppLanguage
    }
    
    public var baseURL: URL {
        return URL(string: AppConfigManager.default.baseAPI())!
    }
    
    public var method: Moya.Method {
        return .post
    }

    public var parameters: [String : Any] {
        return [:]
    }
    
    public var headers: [String : String]? {
        return requestHeaders()
    }
    
    public var validationType: ValidationType {
        return .none
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
    
    public var sampleData: Data {
        return Data()
    }
}
