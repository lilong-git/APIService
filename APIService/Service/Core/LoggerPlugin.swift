//
//  LoggerPlugin.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/10/13.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public final class LoggerPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
        // 网络请求开始
        guard NetworkService.Configuration.default.logEnable else { return }
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        guard NetworkService.Configuration.default.logEnable else { return }
        // 网络请求结束
        switch result {
        case let .success(response):
            let url = response.request?.url?.absoluteString
            let method = response.request?.httpMethod
            let requestHeaders = response.request?.allHTTPHeaderFields
            let requestParams = response.request?.httpBody
            let requestResponse = response.data
            
            print("请求成功✅✅✅: \n" + "请求地址: \(url!)\n" + "请求方式: \(method!)\n" + "请求头: \(JSON(requestHeaders as Any))\n" + "请求参数: \(JSON(requestParams as Any))\n" + "请求响应: \(JSON(requestResponse))\n")
        case let .failure(error):
            print("请求失败🆘🆘🆘: \n\(error)\n")
        }
    }
}
