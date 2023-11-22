//
//  HttpFields.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class HttpFields : Fields {
    let path: String
    let method: String
    let body: String?
    
    init(path: String, method: HttpMethod, body: String? = nil) {
        self.path = path
        self.method = String(describing: method)
        self.body = body
    }
}
