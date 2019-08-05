//
//  HTTPAPITaskTests.swift
//  HTTPTests
//
//  Created by Tian Tong on 2019/8/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import XCTest
import HTTP

class HTTPTaskAPITests: XCTestCase {
    
    var sut: HTTPTask!
    
    let fakeBase = "http://www.fake.com"
    let fakePath = "/fake/path"
    
    override func setUp() {
        super.setUp()
        
        sut = HTTP(base: fakeBase).get(fakePath) { _ in }
    }
    
    func testSuspend() {
        sut.suspend()
        XCTAssertEqual(sut.state, .suspended)
    }
    
    func testResume() {
        sut.resume()
        XCTAssertEqual(sut.state, .running)
    }
    
    func testCancel() {
        sut.cancel()
        XCTAssertEqual(sut.state, .canceling)
    }
    
}
