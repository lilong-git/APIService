//
//  APIService.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/12/25.
//

import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

open class APIService {
    
    let provider: MoyaProvider<MultiTarget>
    
    static let `default`: APIService = {
        APIService(configuration: Configuration.default)
    }()
    
    init(configuration: Configuration) {
        provider = MoyaProvider(configuration: configuration)
    }
}

public extension MoyaProvider {
    convenience init(configuration: Configuration) {
        let endpointClosure = { (target: Target) -> Endpoint in
            MoyaProvider.defaultEndpointMapping(for: target)
                .adding(newHTTPHeaderFields: configuration.addingHeaders(target))
                .replacing(task: target.task)
        }

        let requestClosure = { (endpoint: Endpoint, closure: RequestResultClosure) -> Void in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = configuration.timeoutInterval
                closure(.success(request))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(.parameterEncoding(error)))
            } catch {
                closure(.failure(.underlying(error, nil)))
            }
        }

        self.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            plugins: configuration.plugins
        )
    }
}

public extension TargetType {
    func request() -> Single<Moya.Response> {
        return APIService.default.provider.rx.request(.target(self)).map { (response) -> Response in
            let jsonData = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
            guard jsonData is [String: Any] else {
                throw APIError.responseSerializationException(.jsonSerializationFailed(nil))
            }
            return response
        }
    }
    
    func requestObject<T: Mappable>(_ type: T.Type) -> Single<T> {
        return request().mapObject(type)
    }
    func requestArray<T: Mappable>(_ type: T.Type) -> Single<[T]> {
        return request().mapArray(type)
    }
    func requestResponse() -> Single<BaseResponse> {
        return request().mapResponse(BaseResponse.self)
    }
    
}

public extension Mappable {
    init() {
        self.init(map: Map(mappingType: .fromJSON, JSON: [:]))!
    }
}

