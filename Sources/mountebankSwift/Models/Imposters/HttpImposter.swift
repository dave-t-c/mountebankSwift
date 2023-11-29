//
//  HttpImposter.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class HttpImposter: Imposter {
    let port: Int
    let requestProtocol: String = "http"
    let stubs: [HttpStub]

    init(port: Int, stubs: [HttpStub]) {
        self.port = port
        self.stubs = stubs
    }

    private enum CodingKeys : String, CodingKey {
        case port, requestProtocol = "protocol", stubs
    }
}
