//
//  Property.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public struct Property: Equatable, Identifiable {
    public let title: String
    public let image: URL?
    public let id: String
    
    public init(title: String, image: URL? = nil, id: String) {
        self.title = title
        self.image = image
        self.id = id
    }
}
