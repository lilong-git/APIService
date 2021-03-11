//
//  DateHelper.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/10/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation
import SwiftDate

let KYYYYMMDDDDHHMMSS    = "yyyy-MM-dd HH:mm:ss"
let kYYYYMMDDHHMM        = "yyyy-MM-dd HH:mm"
let kYYYYMMDDHH          = "yyyy-MM-dd HH"
let kYYYYMMDD            = "yyyy-MM-dd"
let kYYYYMM              = "yyyy-MM"
let kYYYY                = "yyyy"

let kHHMM                = "HH:mm"

/**
   时间处理工具
 */
class DateHelper: NSObject {
    
    /**
     当前时间戳
     */
    static func fetchCurrentTimestamp() -> String {
        return String(Int(Date().timeIntervalSince1970))
    }
    
    /**
     当前时间, 精确到秒
     */
    static func currentTime() -> String {
        return Date().toFormat(KYYYYMMDDDDHHMMSS)
    }
    
    /**
     手机系统时间所在时区
     */
    static func utc() -> Int {
        return NSTimeZone.system.secondsFromGMT() / 3600
    }
    
    
}
