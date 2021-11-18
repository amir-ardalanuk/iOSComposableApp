#if DEBUG
//
//  MockPropertyListUsecase.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import Combine

public final class MockPropertyListUsecases: PropertyListUsecases {
    public var resultProvider: (() -> AnyPublisher<PropertyList, Error>)?
    
    func fetchList() -> AnyPublisher<PropertyList, Error> {
        if let provider = resultProvider?() {
            return provider
        }
        return Just(.stub())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

#endif
