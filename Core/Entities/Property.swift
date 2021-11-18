//
//  Property.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public struct Property: Equatable, Identifiable {
    public var title: String
    public var image: URL?
    public var id: String
    
    public init(title: String, image: URL? = nil, id: String) {
        self.title = title
        self.image = image
        self.id = id
    }
}
