//
//  REOApp.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI
import ComposableArchitecture

@main
struct REOApp: App {
    let store = Store(
        initialState: AppState(propertyListState: .init(list: [])),
        reducer: appReducer,
        environment: Enviroment(appUsecases: .live, mainQueue: .main)
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ProperyListView(
                    store: self.store.scope(
                        state: \AppState.propertyListState,
                        action: AppAction.propertyListAction
                    )
                ).navigationBarTitle("Tic-Tac-Toe")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}
