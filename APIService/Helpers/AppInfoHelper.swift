//
//  AppInfoHelper.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/10/10.
//  Copyright © 2020 ZhiYou. All rights reserved.
//

import Foundation
import KeychainAccess

let kAppService      = "AppSerices"
let kAppDeviceUUID   = "AppDeviceUUID"

class AppInfoHelper: NSObject {
    /**
     app包名
     */
    static func appPackageName() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String
    }

    /**
     包装控制器名称
     主要用于字符串装控制器
     */
    static func mapAppPackageName(_ target:String) -> String? {
        if target.isEmpty {
            return AppInfoHelper.appPackageName()
        }
        var packageName = AppInfoHelper.appPackageName()
        packageName = packageName?.replacingOccurrences(of: "-", with: "_")
        return packageName! + "." + target
    }

    /**
     设备 id
     */
    static func deviceUUID() -> String {
        let keychain = Keychain(service: kAppService)
        var deviceId = try? keychain.getString(kAppDeviceUUID)
        if (deviceId == nil || deviceId?.isEmpty == true) {
            deviceId = UIDevice.current.identifierForVendor?.uuidString
            try? keychain.set(deviceId!, key: kAppDeviceUUID)
        }
        return deviceId!
    }
    
    /**
    bundle id
     */
    static func appBundleId() -> String {
        return Bundle.main.bundleIdentifier!
    }
    
    /**
     app 版本
     */
    static func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    /**
     app build 版本
     */
    static func appBuildVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    /**
    app 名称
     */
    static func appName() -> String {
        return Bundle.main.infoDictionary?["CFBundleName"] as! String 
    }
    
    /**
    系统版本
     */
    static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /**
     系统名称
     */
    static func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    /**
    系统类型
     */
    static func systemModel() -> String {
        return UIDevice.current.model
    }
    static func userInterfaceIdiom() -> UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    /**
     设备型号
     */
    static func machineModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier  
    }
}
