//
//  AppConfigManager.swift
//  HiNovelSwift
//
//  Created by Leo on 2021/2/23.
//

import UIKit

class AppConfigManager: NSObject {
    static let `default` = AppConfigManager()
    var configInfo: [String : Any] = [:]
    private override init() {
        self.configInfo = Bundle.main.infoDictionary!
    }
    /// BaseAPI
    public func baseAPI() -> String {
        let host = self.configInfo["APIHost"] as! [String : String]
        if host.keys.contains(LanguageManager.default.currentAppLanguage.rawValue) {
            let baseAPI = host[LanguageManager.default.currentAppLanguage.rawValue]!
            var httpHost = "https://"
            #if DEV
                httpHost = "http://"
            #endif
            let baseURL = httpHost + baseAPI + "/api/"
            return baseURL
        }
        return ""
    }
    
    /// BaseWebAPI
    public func baseWebAPI() -> String {
        let host = self.configInfo["WebHost"] as! [String : String]
        if host.keys.contains(LanguageManager.default.currentAppLanguage.rawValue) {
            let baseAPI = host[LanguageManager.default.currentAppLanguage.rawValue]!
            var httpHost = "https://"
            #if DEV
                httpHost = "http://"
            #endif
            let baseURL = httpHost + baseAPI
            return baseURL
        }
        return ""
    }
    
    /// 分享 BaseLink
    public func shareBaseLink() -> String {
        return self.baseWebAPI() + "/h5/down/\(LanguageManager.default.currentAppLanguage.rawValue).html?"
    }
    
    
}
