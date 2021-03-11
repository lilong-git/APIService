//
//  LanguageManager.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/10/13.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation

/**
 app 语言
 */
public enum AppLanguage: String {
    /// 其他语言
    case other         = "other"
    /// 英语
    case english       = "en"
    /// 泰语
    case thai          = "th"
    /// 越南语
    case vietnamese    = "vi"
    /// 印尼语
    case indonesian    = "id"
    /// 俄语
    case russian       = "ru"
}

class LanguageManager: NSObject {
    private var appCurrentlanguage: AppLanguage = .english

    static let `default` = LanguageManager()
    private override init() {
        
    }
    
    
    var currentAppLanguage: AppLanguage {
        return appCurrentlanguage
    }
    
    public func updateLanguage(language: AppLanguage) {
        appCurrentlanguage = language
    }
    
    public func fetchSystemCurrentLanguage() -> AppLanguage {
        let languages = Locale.preferredLanguages
        let currentSystemLanguage = languages.first
        if ((currentSystemLanguage?.range(of: "id")) != nil) {
            return .indonesian
        }
        if ((currentSystemLanguage?.range(of: "en")) != nil) {
            return .english
        }
        if ((currentSystemLanguage?.range(of: "th")) != nil) {
            return .thai
        }
        if ((currentSystemLanguage?.range(of: "vi")) != nil) {
            return .vietnamese
        }
        if ((currentSystemLanguage?.range(of: "ru")) != nil) {
            return .russian
        }
        return .other
    }
}
