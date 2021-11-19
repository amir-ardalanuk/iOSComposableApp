//
//  AppFeature.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import Core
import Repository
import Network

public struct AppUsecases {
    public var propertyListUsecase: PropertyListUsecases
    
    public init(propertyListUsecase: PropertyListUsecases) {
        self.propertyListUsecase = propertyListUsecase
    }
}


public extension AppUsecases {
    static var live: AppUsecases {
        .init(propertyListUsecase: DefaultProperyUsecases(network: DefaultNetwork()))
    }
    
    static var mock: AppUsecases {
        .init(propertyListUsecase: MockPropertyListUsecases())
    }
}
