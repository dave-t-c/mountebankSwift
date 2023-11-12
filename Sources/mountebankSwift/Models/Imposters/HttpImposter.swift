//
//  HttpImposter.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

struct HttpImposter: Codable {
    let port: Int
    let requestProtocol: String = "http"
    let stubs: [HttpStub]
    
    private enum CodingKeys : String, CodingKey {
        case port, requestProtocol = "protocol", stubs
    }
}
