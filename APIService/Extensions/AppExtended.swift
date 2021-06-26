//
//  AppExtended.swift
//  APIService
//
//  Created by Simon on 2021/6/26.
//

import Foundation


/// 泛型扩展,  方法隔离, 减少对系统方法的污染

public struct AppExtension<ExtendedType> {
    
    public private(set) var type: ExtendedType
    
    public init(_ type: ExtendedType) {
        self.type = type
    }
}

public protocol AppExtended {
    associatedtype ExtendedType
    
    static var ex: AppExtension<ExtendedType>.Type { get set }
    
    var ex: AppExtension<ExtendedType> { get set }
}

extension AppExtended {
    public static var ex: AppExtension<Self>.Type {
        get { AppExtension<Self>.self }
        set {}
    }
    
    public var ex: AppExtension<Self> {
        get { AppExtension(self) }
        set {}
    }
}
