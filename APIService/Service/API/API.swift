//
//  API.swift
//  HiNovelSwift
//
//  Created by long on 2020/12/25.
//

import Foundation
import Moya



public enum API {

    public enum Discover {
        case index
        case banner
    }
   
}


extension API.Discover: APITargetType {
    public var path: String {
        switch self {
        case .index:            return kDiscoverIndex
        case .banner:           return kDiscoverBanner
       
        }
    }
    public var parameters: [String : Any] {
        switch self {
        case .index:
            return ["is_r18": 0, "preference": 1]
        case .banner:
            return [:]
        }
    }
}


