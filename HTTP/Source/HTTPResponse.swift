//
//  HTTPResponse.swift
//  HTTP
//
//  Created by Tian Tong on 2019/8/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import Foundation

protocol Response {
    var data: Data? { get }
    var urlResponse: URLResponse? { get }
    var error: HTTPError? { get }
}

public struct HTTPResponse: Response {
    
    public var data: Data?
    public var urlResponse: URLResponse?
    public var error: HTTPError?
    
    public var url: URL?    // Download task completion callback parameter
    
    var fakeRequest: HTTPDataRequest?
    
    public var message: String? {
        if data != nil {
            return String(data: data!, encoding: .utf8)
        }
        return nil
    }
    
    public var json: [String: Any]? {
        return parseJSON()
    }
    
    public var jsonArray: [Any]? {
        return parseJSONArray()
    }
    
    public var status: HTTPStatus {
        let code = (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
        return HTTPStatus(code: code)
    }
    
    public var statusCode: Int {
        return (urlResponse as? HTTPURLResponse)?.statusCode ?? 0
    }
    
    public var headers: [String: String] {
        return (urlResponse as? HTTPURLResponse)?.allHeaderFields as? [String: String] ?? [:]
    }
    
    /* ✅ */
    public init(data: Data? = nil, url: URL? = nil, response: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.url = url
        self.urlResponse = response
        self.error = (error == nil) ? nil : error as? HTTPError ?? HTTPError.responseError(error!)
    }
    
    // MARK: - Methods
    
    private func parseJSON() -> [String: Any]? {
        guard data != nil else { return nil }
        
        if let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any] {
            return json
        }
        return nil
    }
    
    private func parseJSONArray() -> [Any]? {
        guard data != nil else { return nil }
        
        if let jsonArray = try? JSONSerialization.jsonObject(with: data!) as? [Any] {
            return jsonArray
        }
        return nil
    }
    
}

extension HTTPResponse {
    
    init(fakeRequest: HTTPRequest) {
        self.fakeRequest = fakeRequest as? HTTPDataRequest
    }
    
}

struct DecodableResponse<T: Decodable>: Response {
    
    let data: Data?
    let urlResponse: URLResponse?
    let error: HTTPError?
    
    var entity: T?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = response
        self.error = (error == nil) ? nil : error as? HTTPError ?? HTTPError.responseError(error!)
    }
    
}
