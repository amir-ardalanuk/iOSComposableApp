//
//  PropertyListTest.swift
//  REOTests
//
//  Created by Faraz Karimi on 8/28/1400 AP.
//

import Foundation
import XCTest
import ComposableArchitecture
import Combine
import Repository
import Core
@testable import REO

class PropertyListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testProppertyFetching_Successfully() {
        let appUsecases = AppUsecases.mock
        let mockProperty = appUsecases.propertyListUsecase as! MockPropertyListUsecases
        let testProperty = Property(title: "Test", image: nil, id: "ID", address: "")
        let list = PropertyList.init(list: [testProperty], hasMore: false, nextId: nil)
        
        mockProperty.resultProvider = {
            Just(list)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let store = TestStore(
            initialState: AppState(propertyListState: .init(list: [])),
            reducer: appReducer,
            environment: Enviroment.init(appUsecases: appUsecases, mainQueue: .main)
      )
        
        store.assert(
            .send(.propertyListAction(.fetch)) {
                $0.propertyListState.loadingState = .loading
            },
            .receive(.propertyListAction(.loadedData(list))) {
                $0.propertyListState.list = [testProperty]
                $0.propertyListState.loadingState = ProperyListState.LoadingState.ready(hasMore: false, next: nil)
            }
        )
    }
    
    func testProppertyFetching_Pagination_Successfully() {
        let appUsecases = AppUsecases.mock
        let mockProperty = appUsecases.propertyListUsecase as! MockPropertyListUsecases
        let testProperty = Property(title: "Test", image: nil, id: "ID", address: "")
        let list = PropertyList.init(list: [testProperty], hasMore: true, nextId: 2)
        
        mockProperty.resultProvider = {
            Just(list)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let store = TestStore(
            initialState: AppState(propertyListState: .init(list: [])),
            reducer: appReducer,
            environment: Enviroment.init(appUsecases: appUsecases, mainQueue: .main)
      )
        
        store.assert(
            .send(.propertyListAction(.fetch)) {
                $0.propertyListState.loadingState = .loading
            },
            .receive(.propertyListAction(.loadedData(list))) {
                $0.propertyListState.list = [testProperty]
                $0.propertyListState.loadingState = ProperyListState.LoadingState.ready(hasMore: true, next: 2)
            }
        )
    }
    
    func testProppertyFetching_Pagination_EndOfThePage() {
        let appUsecases = AppUsecases.mock
        let mockProperty = appUsecases.propertyListUsecase as! MockPropertyListUsecases
        let testProperty = Property(title: "Test", image: nil, id: "ID", address: "")
        let list = PropertyList.init(list: [testProperty], hasMore: false, nextId: nil)
        
        mockProperty.resultProvider = {
            Just(list)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let store = TestStore(
            initialState: AppState(propertyListState: .init(list: [testProperty], loadingState: .ready(hasMore: false, next: nil), detail: nil)),
            reducer: appReducer,
            environment: Enviroment.init(appUsecases: appUsecases, mainQueue: .main)
      )
        
        store.assert(
            .send(.propertyListAction(.fetch)) {
                $0.propertyListState.list = [testProperty]
            }
        )
    }
}

