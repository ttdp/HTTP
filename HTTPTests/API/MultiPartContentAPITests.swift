//
//  MultiPartContentAPITests.swift
//  HTTPTests
//
//  Created by Tian Tong on 2019/8/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import XCTest
import HTTP

class MultiPartContentAPITests: XCTestCase {
    
    var sut: MultiPartContent!
    
    func testInitWithData() {
        sut = MultiPartContent(name: "file", fileName: "swift.jpg", type: .jpg, data: Data())
        XCTAssertNotNil(sut)
    }
    
    func testInitWithURL() {
        let fileURL = URL(string: "/upload/swift.jpg")!
        sut = MultiPartContent(name: "file", type: .jpg, url: fileURL)
        XCTAssertNotNil(sut)
    }
    
}
