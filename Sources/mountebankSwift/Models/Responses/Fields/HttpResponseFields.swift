//
//  HttpResponseFieldss.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

struct HttpResponseFields: Codable {
    
    init(statusCode: Int, headers: Dictionary<String, String>, body: String? = nil) {
        self.statusCode = statusCode
        self.headers = headers
        self.body = body
    }
    
    let statusCode: Int
    let headers: Dictionary<String, String>
    var body: String?
}