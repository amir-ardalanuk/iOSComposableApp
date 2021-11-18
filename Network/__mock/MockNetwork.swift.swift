#if DEBUG
//
//  MockNetwork.swift.swift
//  Network
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public final class MockNetwork: NetworkProtocol {
    
    public var resultProvider: Any?
    
    public func request<T>(_ request: URLRequest, result: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        if let provider = resultProvider as? (Result<T, NetworkError>) {
            result(provider)
        } else {
            fatalError("provider not injected")
        }
    }
}

#endif
