//
//  Property+Stubing.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation

public extension Property {
    static func stub(id: String = UUID().uuidString ) -> Property {
        .init(title: "Amir", image: URL(string:""), id: id)
    }
}
