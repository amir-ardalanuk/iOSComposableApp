//
//  PropertyDetail.swift
//  REO
//
//  Created by Faraz Karimi on 8/28/1400 AP.
//

import SwiftUI
import ComposableArchitecture

struct PropertyDetailView: View {
    var store: Store<PropertyDetailState, PropertyDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                
            }
            .navigationTitle(viewStore.property.title)
        }
    }
}

extension PropertyDetailView {
    struct ViewState {
        let image: URL?
        let title: String?
    }
}
//struct PropertyDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        //PropertyDetail()
//    }
//}
