//
//  PropertyDetaiReducer.swift
//  REO
//
//  Created by Faraz Karimi on 8/28/1400 AP.
//

import Foundation
import Core
import ComposableArchitecture

struct PropertyDetailState: Equatable {
    var property: Property
}

public enum PropertyDetailAction: Equatable {
    case none
}

struct PropertyDetailEnv {
    
}

var propertyDetailReducer = Reducer<PropertyDetailState, PropertyDetailAction, PropertyDetailEnv> { _, _, _ in
    return .none
}
