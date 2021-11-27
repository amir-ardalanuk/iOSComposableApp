//
//  ProperyList.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI
import ComposableArchitecture
import Core

struct ProperyListView: View {
    let store: Store<ProperyListState, PropertyListAction>
    
    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init, action: PropertyListAction.init)) { viewStore in
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVStack(spacing: 8) {
                            ForEach(viewStore.items) { item in
                                NavigationLink(
                                  destination: IfLetStore(
                                    self.store.scope(state: \.detail, action: PropertyListAction.detailAction),
                                    then: PropertyDetailView.init(store:)
                                  ),
                                  isActive: viewStore.binding(
                                    get: \.isDetailViewActive,
                                    send: { $0 ? .showDetail(item) : .dismissDetail }
                                  )
                                ) {
                                    PropertyItem(item: item)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .disabled(viewStore.isLoading)
                            }
                            Rectangle()
                                .frame(width: 1, height: 1)
                                .onAppear {
                                    viewStore.send(.fetch)
                                }
                        }
                    }
                }
                if viewStore.isLoading {
                    ProgressView()
                }
            }
        }.debug()
        .navigationTitle("Propertis")
        .padding(16.0)
    }
    
}

extension ProperyListView {
    struct ViewState: Equatable {
        let items: [PropertyItem.Property]
        let isLoading: Bool
        let isDetailViewActive: Bool
        
        init(state: ProperyListState) {
            items = state.list.map {
                PropertyItem.Property.init(property: $0)
            }
            self.isLoading = state.loadingState == .loading
            self.isDetailViewActive = state.detail != nil
        }
    }
    
    enum ViewAction {
        case fetch
        case error
        case showDetail(PropertyItem.Property)
        case dismissDetail
    }
}

extension PropertyListAction {
    init(action: ProperyListView.ViewAction) {
        switch action {
        case .fetch:
            self = .fetch
        case .dismissDetail:
            self = .dismisDetail
        case let .showDetail(detail):
            self = .detailProperty(id: detail.id)
        case .error:
            self = .failedFetching(nil)
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
