//
//  NetworkProtocol.swift
//  Network
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public enum NetworkError: Error, Equatable {
    case uknownError
    case decoderError(DecoderError)
    case serverError(String)
    case invalidURL
}

public protocol NetworkProtocol {
    func request(_ request: URLRequest, result: @escaping (Result<Data, NetworkError>) -> Void )
}
