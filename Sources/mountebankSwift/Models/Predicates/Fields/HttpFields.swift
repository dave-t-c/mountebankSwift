//
//  HttpFields.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

public class HttpFields: Fields {
    public var path: String
    public var method: String
    public var body: String?

    public init(path: String, method: HttpMethod, body: String? = nil) {
        self.path = path
        self.method = String(describing: method)
        self.body = body
    }
}
