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
    var path: String
    var body: String
    var method: HttpMethod
    var headers: [String: String]

    init(path: String, body: String, method: HttpMethod, headers: [String: String]) {
        self.path = path
        self.body = body
        self.method = method
        self.headers = headers
    }
}
