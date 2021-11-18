//
//  ProperyList.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI
import ComposableArchitecture

struct ProperyListView: View {
    let store: Store<ProperyListState, PropertyListAction>
    
    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init, action: PropertyListAction.init)) { viewStore in
            VStack {
                if viewStore.isLoading {
                    ProgressView()
                }
                ScrollView {
                    VStack {
                        LazyVStack(spacing: 8) {
                            ForEach(viewStore.items) { item in
                                NavigationLink(destination: {
                                    Text("Detail")
                                }, label: {
                                    PropertyItem(item: item)
                                }).buttonStyle(PlainButtonStyle())
                            }
                            Rectangle()
                                .frame(width: 1, height: 1)
                                .onAppear {
                                    viewStore.send(.fetch)
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle("Propertis")
        .padding(16.0)
    }
    
}

extension ProperyListView {
    struct ViewState: Equatable {
        let items: [PropertyItem.Property]
        let isLoading: Bool
        
        init(state: ProperyListState) {
            items = state.list.map {
                PropertyItem.Property.init(property: $0)
            }
            self.isLoading = state.loadingState == .loading
        }
    }
    
    enum ViewAction {
        case fetch
        case error
    }
}

extension PropertyListAction {
    init(action: ProperyListView.ViewAction) {
        switch action {
        case .fetch:
            self = .fetch
        case .error:
            self = .failedFetching("")
        }
    }
}

struct ProperyList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProperyListView(store: properyListReducerStub)
        }
        
    }
}
