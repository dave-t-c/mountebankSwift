//
//  HttpFields.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

struct HttpFields : Codable {
    
    init(path: String, method: HttpMethod) {
        self.path = path
        self.method = String(describing: method)
    }
    
    let path: String
    let method: String
}
