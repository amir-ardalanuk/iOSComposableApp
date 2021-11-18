//
//  PropertyList+Reducer.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import ComposableArchitecture
import Core
import Repository
import Combine

struct ProperyListState: Equatable {
    let list: [Property]
    let loadingState: LoadingState
    
    init(list: [Property], loadingState: ProperyListState.LoadingState = LoadingState.initial) {
        self.list = list
        self.loadingState = loadingState
    }
    
    
    func update(list: [Property], loadingState: LoadingState) -> ProperyListState {
        .init(list: self.list + list, loadingState: loadingState)
    }
    
    enum LoadingState: Equatable {
        case loading
        case ready(hasMore: Bool, next: Int?)
        
        static var initial: LoadingState {
            .ready(hasMore: true, next: 1)
        }
    }
}

public enum PropertyListAction: Equatable {
    case fetch
    case loadedData(Core.PropertyList)
    case failedFetching(String)
}


struct PropertyListEnviroment {
    var feature: AppUsecases
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


var propertyListReducer = Reducer<ProperyListState, PropertyListAction, PropertyListEnviroment> { state, action , env in
    switch action {
    case let .loadedData(propertyList):
        state = state.update(
            list: propertyList.list,
            loadingState: ProperyListState.LoadingState.ready(hasMore: propertyList.hasMore, next: propertyList.nextId)
        )
        return .none
    case .fetch:
        guard case let .ready(true, _nextId) = state.loadingState,
              let nextId = _nextId else {
            return .none
        }
        state = state.update(list: state.list, loadingState: .loading)
        return env.feature.propertyListUsecase.fetchList(count: 10, page: nextId)
            .receive(on: env.mainQueue)
            .map {
                PropertyListAction.loadedData($0)
            }
            .catch { error in
                Just(PropertyListAction.failedFetching(error.localizedDescription))
            }
            .eraseToEffect()

    case let .failedFetching(error):
        print(error)
        return .none
    }
}


var properyListReducerStub = Store<ProperyListState, PropertyListAction>.init(
    initialState: .init(list: [.stub(), .stub()]),
    reducer: propertyListReducer,
    environment: PropertyListEnviroment(feature: .live, mainQueue: .main))


