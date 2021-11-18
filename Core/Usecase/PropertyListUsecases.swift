//
//  ProprtyListServies.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import Combine

public protocol PropertyListUsecases {
    func fetchList(count: Int, page: Int) -> AnyPublisher<PropertyList, Error>
}
