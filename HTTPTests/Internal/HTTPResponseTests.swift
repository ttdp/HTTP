//
//  HTTPResponseTests.swift
//  HTTPTests
//
//  Created by Tian Tong on 2019/8/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import XCTest
@testable import HTTP

class HTTPResponseTests: XCTestCase {
    
    var sut: HTTPResponse!
    
    let fakeBase = "http://www.fake.com"
    let fakePath = "/fake/path"
    
    func testInitWithFakeRequest() {
        var request = HTTPDataRequest(base: fakeBase, path: fakePath, method: .get, params: nil, headers: nil, sessionConfig: .standard)
        
        sut = HTTPResponse(fakeRequest: request)
        
        XCTAssertEqual(sut.fakeRequest!.base, fakeBase)
        XCTAssertEqual(sut.fakeRequest!.path, fakePath)
        XCTAssertEqual(sut.fakeRequest!.method, .get)
        XCTAssertEqual(sut.fakeRequest!.session, URLSessionManager.shared.getSession(with: .standard))
        XCTAssertEqual(sut.fakeRequest!.taskType, .data)
        XCTAssertNil(sut.fakeRequest!.params)
        XCTAssertNil(sut.fakeRequest!.headers)
        XCTAssertNil(sut.fakeRequest!.bodyData)
        XCTAssertNotNil(sut.fakeRequest!.urlRequest)
        
        let content = MultiPartContent(name: "", fileName: "", type: .jpg, data: Data())
        request = HTTPDataRequest(base: fakeBase, path: fakePath, method: .post, params: ["key": "value"], headers: ["key": "value"], sessionConfig: .background("bg"), taskType: .upload(content))
        
        sut = HTTPResponse(fakeRequest: request)
        
        XCTAssertEqual(sut.fakeRequest!.base, fakeBase)
        XCTAssertEqual(sut.fakeRequest!.path, fakePath)
        XCTAssertEqual(sut.fakeRequest!.method, .post)
        XCTAssertEqual(sut.fakeRequest!.session, URLSessionManager.shared.getSession(with: .background("bg")))
        XCTAssertEqual(sut.fakeRequest!.taskType, .upload(content))
        XCTAssertEqual(sut.fakeRequest!.params!["key"] as! String, "value")
        XCTAssertEqual(sut.fakeRequest!.headers!["key"], "value")
        XCTAssertNil(sut.fakeRequest!.bodyData)
        XCTAssertNotNil(sut.fakeRequest!.urlRequest)
    }
    
}
