//
//  HTTPAPIResponseTests.swift
//  HTTPTests
//
//  Created by Tian Tong on 2019/8/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import XCTest
import HTTP

class HTTPResponseAPITests: XCTestCase {
    
    var sut: HTTPResponse!
    
    func testInit() {
        sut = HTTPResponse()
        
        XCTAssertNil(sut.data)
        XCTAssertNil(sut.urlResponse)
        XCTAssertNil(sut.error)
        XCTAssertNil(sut.url)
        XCTAssertNil(sut.json)
        XCTAssertNil(sut.jsonArray)
        XCTAssertEqual(sut.status.description, "0 - Unknown")
    }
    
    func testInitWithData() {
        sut = HTTPResponse(data: "some".data(using: .utf8), response: URLResponse(), error: nil)
        
        XCTAssertEqual(sut.data, "some".data(using: .utf8))
        XCTAssertNotNil(sut.urlResponse)
        XCTAssertNil(sut.error)
    }
    
    func testInitWithURL() {
        let url = URL(string: "/download/path")
        sut = HTTPResponse(url: url, response: URLResponse(), error: nil)
        
        XCTAssertEqual(sut.url, url)
        XCTAssertNotNil(sut.urlResponse)
        XCTAssertNil(sut.error)
    }
    
    func testStatusCode() {
        let httpResponse = HTTPURLResponse(url: URL(string: "www.ttdp.com")!, statusCode: 200, httpVersion: "1.1", headerFields: nil)
        sut = HTTPResponse(response: httpResponse)
        
        XCTAssertEqual(sut.statusCode, 200)
        XCTAssertEqual(sut.status, .ok)
        XCTAssertEqual(sut.status.description, "200 - OK")
    }
    
    func testMessage() {
        let data = "Hello World!".data(using: .utf8)
        sut = HTTPResponse(data: data)
        
        XCTAssertEqual(sut.message, "Hello World!")
    }
    
}
