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
        })
)
    .debug()
