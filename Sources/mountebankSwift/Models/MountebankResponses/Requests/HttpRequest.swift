//
//  HttpRequest.swift
//
//
//  Created by David Cook on 29/11/2023.
//

import Foundation

/// Models a HttpRequest made to mountebank
///
public class HttpRequest: Codable {
    public let path: String
    public let body: String
    public let method: HttpMethod
    public let headers: [String: String]

    init(path: String, body: String, method: HttpMethod, headers: [String: String]) {
        self.path = path
        self.body = body
        self.method = method
        self.headers = headers
    }
}
