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
    let detail: PropertyDetailState?
    
    init(list: [Property], loadingState: ProperyListState.LoadingState = LoadingState.initial, detail: PropertyDetailState? = nil) {
        self.list = list
        self.loadingState = loadingState
        self.detail = detail
    }
    
    func update(list: [Property]) -> ProperyListState {
        .init(list: self.list + list, loadingState: self.loadingState, detail: self.detail)
    }
    
    func update(loadingState: LoadingState) -> ProperyListState {
        .init(list: self.list, loadingState: loadingState, detail: self.detail)
    }
    
    func update(detail: PropertyDetailState?) -> ProperyListState {
        .init(list: self.list, loadingState: self.loadingState, detail: detail)
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
    case failedFetching(String?)
    case detailProperty(id: String)
    case dismisDetail
    case detailAction(PropertyDetailAction)
}


struct PropertyListEnviroment {
    var feature: AppUsecases
    var mainQueue: AnySchedulerOf<DispatchQueue>
}


var propertyListReducer = Reducer<ProperyListState, PropertyListAction, PropertyListEnviroment> { state, action , env in
    switch action {
    case let .loadedData(propertyList):
        state = state.update(
            list: propertyList.list
        ).update(loadingState: .ready(hasMore: propertyList.hasMore, next: propertyList.nextId))
        return .none
    case .fetch:
        guard case let .ready(true, _nextId) = state.loadingState,
              let nextId = _nextId else {
            return .none
        }
        state = state.update(loadingState: .loading)
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
        // FIXME: - implement error state
        return .none
    case .dismisDetail:
        state = state.update(detail: nil)
        return .none
    case .detailProperty, .detailAction:
        return .none
    }
}


var properyListReducerStub = Store<ProperyListState, PropertyListAction>.init(
    initialState: .init(list: [.stub(), .stub()]),
    reducer: propertyListReducer,
    environment: PropertyListEnviroment(feature: .live, mainQueue: .main))


