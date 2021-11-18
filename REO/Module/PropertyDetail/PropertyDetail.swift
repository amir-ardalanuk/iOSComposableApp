//
//  PropertyDetail.swift
//  REO
//
//  Created by Faraz Karimi on 8/28/1400 AP.
//

import SwiftUI
import ComposableArchitecture
import Core

struct PropertyDetailView: View {
    var store: Store<PropertyDetailState, PropertyDetailAction>
    
    var body: some View {
        WithViewStore(store.scope(state: ViewState.init, action: PropertyDetailAction.init)) { viewStore in
            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: viewStore.image) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width * 9/16 )
                            .background(Color.gray)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.width * 9/16 )
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    
                    
                    if viewStore.price != nil {
                        makeRow(title: "Price", value: viewStore.price!)
                    }
                    
                    if viewStore.address != nil {
                        makeRow(title: "Address", value: viewStore.address!)
                    }
                }.frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                    .navigationTitle(viewStore.title)
            }
            .padding(16)
        }
    }
    
    @ViewBuilder
    func makeRow(title: String, value: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            Text(title)
                .foregroundColor(.gray)
                .frame(width: 70, alignment: .leading)
            Text(value)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

extension PropertyDetailView {
    struct ViewState: Equatable {
        let image: URL?
        let title: String
        let price: String?
        let address: String?
    }
    
    enum ViewAction {}
}

extension PropertyDetailView.ViewState {
    init(state: PropertyDetailState) {
        self.image = state.property.image
        self.title = state.property.title
        self.address = state.property.address
        self.price = "250.000 $"
    }
}

extension PropertyDetailAction {
    init(action: PropertyDetailView.ViewAction) {
        self = PropertyDetailAction.none
    }
}
//struct PropertyDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        //PropertyDetail()
//    }
//}
