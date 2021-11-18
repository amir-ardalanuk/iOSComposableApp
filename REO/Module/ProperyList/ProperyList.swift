//
//  ProperyList.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI

struct ProperyList: View {
    
    var list = [Property]()
    var body: some View {
        VStack {
            Text("Properties")
                .font(Theme.global.font.bold(size: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            LazyVStack {
                ForEach(list) { item in
                    HStack(spacing: 16) {
                        AsyncImage(url: item.imageURL)
                            .frame(width: 64, height: 64, alignment: .center)
                            .cornerRadius(8)
                            
                        
                        Text(item.title)
                            .font(Theme.global.font.regular(size: 18))
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
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
    struct Property: Identifiable {
        var id: String
        var title: String
        var imageURL: URL?
    }

}

struct ProperyList_Previews: PreviewProvider {
    static var previews: some View {
        ProperyList(list: [.init(id: UUID.init().uuidString, title: "Amir", imageURL: URL.init(string: "https://picsum.photos/100/100"))])
    }
}
