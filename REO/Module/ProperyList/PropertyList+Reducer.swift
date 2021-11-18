//
//  PropertyList+Reducer.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import ComposableArchitecture
import Core

struct ProperyListState: Equatable {
    var list: [Property]
}

enum ProperyListAction {
    case fetch
}

struct ProperyListEnviroment { }


var properyListReducer = Reducer<ProperyListState, ProperyListAction, ProperyListEnviroment> { state, action , env in
    return .none
}


var properyListReducerStub = Store<ProperyListState, ProperyListAction>.init(initialState: .init(list: [.stub(), .stub()]), reducer: properyListReducer, environment: ProperyListEnviroment())


