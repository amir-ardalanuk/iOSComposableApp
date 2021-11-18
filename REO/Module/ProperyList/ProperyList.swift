//
//  ProperyList.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI

struct ProperyList: View {
    
    var list = [PropertyItem.Property]()
    var body: some View {
        VStack {
            Text("Properties")
                .font(Theme.global.font.bold(size: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            LazyVStack {
                ForEach(list) { item in
                    PropertyItem(item: item)
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

struct ProperyList_Previews: PreviewProvider {
    static var previews: some View {
        ProperyList(list: [.stub, .stub])
    }
}
