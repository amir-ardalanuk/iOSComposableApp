//
//  PropperyList.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public struct PropertyList {
    public let list: [Property]
    public let hasMore: Bool
    public let nextId: Int?
    
    public init(list: [Property], hasMore: Bool, nextId: Int? = nil) {
        self.list = list
        self.hasMore = hasMore
        self.nextId = nextId
    }
}
