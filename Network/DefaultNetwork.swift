//
//  DefaultNetwork.swift
//  Network
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

final public class DefaultNetwork: NetworkProtocol {
    
    // MARK: - Property
    var urlSession: URLSession {
        return URLSession.shared
    }
    
    // MARK: - init
    public init() { }
    
    
    // MARK: - DefaultNetwork protocol api's
    
    public func request(_ request: URLRequest, result: @escaping (Result<Data, NetworkError>) -> Void ) {
        urlSession.dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    result(.failure(.serverError("Something went wrong! Please try again later: error description" +  error.localizedDescription)))
                } else {
                    result(.failure(NetworkError.uknownError))
                }
                return
            }
            result(.success(data))
        }.resume()
    }
}
