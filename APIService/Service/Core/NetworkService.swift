//
//  NetworkService.swift
//  HiNovelSwift
//
//  Created by Leo on 2020/12/25.
//

import Moya
import RxSwift
import SwiftyJSON
import ObjectMapper

open class NetworkService {
    
    public let provider: MoyaProvider<MultiTarget>
    
    public static let `default`: NetworkService = {
        NetworkService(configuration: Configuration.default)
    }()
    
    public init(configuration: Configuration) {
        provider = MoyaProvider(configuration: configuration)
    }
}

public extension MoyaProvider {
    convenience init(configuration: NetworkService.Configuration) {
        let endpointClosure = { target -> Endpoint in
            MoyaProvider.defaultEndpointMapping(for: target)
                        .adding(newHTTPHeaderFields: configuration.addingHeaders(target))
                        .replacing(task: configuration.replacingTask(target))
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
        return NetworkService.default.provider.rx.request(.target(self)).map { (response) -> Response in
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


open class DecimalTransform: TransformType {
    
    public typealias Object = Decimal
    
    public typealias JSON = Decimal
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Decimal? {
        if let number = value as? NSNumber {
            return Decimal(string: number.description)
        }
        if let number = value as? String {
            return Decimal(string: number)
        }
        return nil
    }
    
    public func transformToJSON(_ value: Decimal?) -> Decimal? {
        return value
    }

}
