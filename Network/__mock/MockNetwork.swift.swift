#if DEBUG
//
//  MockNetwork.swift.swift
//  Network
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import Combine

public final class MockNetwork: NetworkProtocol {
    
    public var resultProvider: Any?
    
    public func request<T>(_ request: URLRequest, result: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        if let provider = resultProvider as? (Result<T, NetworkError>) {
            result(provider)
        } else {
            fatalError("provider not injected")
        }
    }
    
    public func request<T>(_ request: URLRequest, type: T.Type) -> AnyPublisher<T, Error> where T : Decodable {
        if let provider = resultProvider as? (Result<T, NetworkError>) {
            return Just(try! provider.get())
                .mapError { _ -> Error in
                    NSError()
                }
                .eraseToAnyPublisher()
        } else {
            fatalError("provider not injected")
        }
    }
}

#endif
