//
//  ProprtyListServies.swift
//  Core
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import Combine

protocol PropertyListUsecases {
    func fetchList() -> AnyPublisher<PropertyList, Error>
}
