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

struct AppUsecases {
    var propertyListUsecase: PropertyListUsecases
}


extension AppUsecases {
    static var live: AppUsecases {
        .init(propertyListUsecase: DefaultProperyUsecases(network: DefaultNetwork()))
    }
    
    static var mock: AppUsecases {
        .init(propertyListUsecase: MockPropertyListUsecases())
    }
}
