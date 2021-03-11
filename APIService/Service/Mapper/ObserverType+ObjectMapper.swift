//
//  ObserverType+ObjectMapper.swift
//  HiNovelSwift
//
//  Created by long on 2020/12/25.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

public extension ObservableType where Element == Response {

    func mapObject<T: Mappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObject(type, context: context))
        }
    }

    func mapArray<T: Mappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapArray(type, context: context))
        }
    }
    
    func mapResponse<T: Mappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapResponse(type, context: context))
        }
    }
}
