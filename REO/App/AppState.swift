//
//  AppState.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import ComposableArchitecture

public struct AppState {
    var propertyListState: ProperyListState
}

public enum AppAction {
    case propertyListAction(PropertyListAction)
}

public struct Enviroment {
    let appUsecases: AppUsecases
    let mainQueue: AnySchedulerOf<DispatchQueue>
}

var appReducer = Reducer<AppState, AppAction, Enviroment>.combine(
    propertyListReducer.pullback(
        state: \AppState.propertyListState, action: /AppAction.propertyListAction, environment: {
            PropertyListEnviroment(feature: $0.appUsecases, mainQueue: .main)
        }),
    Reducer<AppState, AppAction, Enviroment> { state, action, env in
        switch action {
        case let .propertyListAction(.detailProperty(id)):
            guard let property = state.propertyListState.list.filter({ $0.id == id }).first else {
                return .none
            }
            state.propertyListState = state.propertyListState.update(detail: .init(property: property))
            return .none
        default:
            return .none
        }
    }
)
    .debug()
