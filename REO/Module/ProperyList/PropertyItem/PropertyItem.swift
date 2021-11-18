//
//  PropertyItem.swift
//  REO
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import SwiftUI

struct PropertyItem: View {
    var item: Property
    
    var body: some View {
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

extension PropertyItem {
    struct Property: Identifiable {
        var id: String
        var title: String
        var imageURL: URL?
    }
}

extension PropertyItem.Property {
   static var stub: PropertyItem.Property {
        .init(id: UUID.init().uuidString, title: "Amir", imageURL: URL.init(string: "https://picsum.photos/100/100"))
    }
}
struct PropertyItem_Previews: PreviewProvider {
    static var previews: some View {
        PropertyItem(item: .stub)
    }
}
