//
//  HttpResponseFieldss.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

public class HttpResponseFields: ResponseFields {
    public var statusCode: Int
    public var headers: [String: String]?
    public var body: String?

    public init(statusCode: Int, headers: [String: String]? = nil, body: String? = nil) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
}
