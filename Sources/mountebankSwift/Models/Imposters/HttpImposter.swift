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
    let recordRequests: Bool
    let name: String?

    init(port: Int, stubs: [HttpStub], recordRequests: Bool = true, name: String? = nil) {
        self.port = port
        self.stubs = stubs
        self.recordRequests = recordRequests
        self.name = name
    }

    private enum CodingKeys: String, CodingKey {
        case port, requestProtocol = "protocol", stubs, recordRequests, name
    }
}
