//
//  SimpleRetrievedImposter.swift
//
//
//  Created by David Cook on 26/11/2023.
//

import Foundation

class SimpleRetrievedImposter: Codable {
    var port: Int
    var requestProtocol: String
    var numberOfRequests: Int

    init(port: Int, requestProtocol: String, numberOfRequests: Int, recordRequests: Bool) {
        self.port = port
        self.requestProtocol = requestProtocol
        self.numberOfRequests = numberOfRequests
    }

    private enum CodingKeys: String, CodingKey {
        case port, requestProtocol = "protocol", numberOfRequests
    }
}
