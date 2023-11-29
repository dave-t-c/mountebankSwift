//
//  HttpResponseFieldss.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class HttpResponseFields: ResponseFields {
    let statusCode: Int
    let headers: [String: String]?
    var body: String?

    init(statusCode: Int, headers: [String: String]? = nil, body: String? = nil) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
}
