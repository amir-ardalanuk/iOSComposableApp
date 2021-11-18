//
//  DefaultNetworkTests.swift
//  NetworkTests
//
//  Created by Faraz Karimi on 8/27/1400 AP.
//

import Foundation
import XCTest
@testable import Network

final class DefaultNetworkTest: XCTestCase {
    // MARK: - Properties
    let sut: NetworkProtocol = DefaultNetwork()
    
    // MARK: - Life Cycle
    override func setUp() {
        super.setUp()
    }
}

extension DefaultNetworkTest {
    func testFetchGETApiSuccessfully() {
        let url = URL(string: "https://google.com")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        
        let expectation = self.expectation(description: "Wait for \(url) to load.")
        var data: Data?
        
        sut.request(request) { (result) in
            data = try? result.get()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func testFetchGETApiFailure() {
        let url = URL(string: "https://mockingurl.c")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        
        let expectation = self.expectation(description: "Wait for \(url) to load.")
        var error: NetworkError?
        
        sut.request(request) { (result: Result<Data, NetworkError>) in
            guard case .failure(let networkError) = result else {
                return XCTFail("Expected to be a failure but got a success with \(result)")
            }
            error = networkError
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(error)
    }
}


