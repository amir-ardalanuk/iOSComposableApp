//
//  ProperyList.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI
import ComposableArchitecture

struct ProperyList: View {
    let store: Store<ProperyListState, ProperyListAction>
    
    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init, action: ProperyListAction.init)) { viewStore in
            VStack {
                Text("Properties")
                    .font(Theme.global.font.bold(size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                LazyVStack {
                    ForEach(viewStore.items) { item in
                        PropertyItem(item: item)
                    }
                }
            }
        }
        .padding(16.0)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .top)
        
    }
}

extension ProperyList {
    struct ViewState: Equatable {
        var items: [PropertyItem.Property]
        
        init(state: ProperyListState) {
            items = state.list.map {
                PropertyItem.Property.init(property: $0)
            }
        }
    }
    
    enum ViewAction {
        case fetch
    }
}

extension ProperyListAction {
    init(action: ProperyList.ViewAction) {
        switch action {
        case .fetch:
            self = .fetch
        }
    }
}

struct ProperyList_Previews: PreviewProvider {
    static var previews: some View {
        ProperyList(store: properyListReducerStub)
    }
}
