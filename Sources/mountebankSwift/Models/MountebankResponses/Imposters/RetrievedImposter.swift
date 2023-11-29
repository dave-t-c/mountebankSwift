//
//  RetrievedImposter.swift
//
//
//  Created by David Cook on 26/11/2023.
//

import Foundation

class RetrievedImposter: Codable {
    var port: Int
    var requestProtocol: String
    var numberOfRequests: Int
    
    init(port: Int, requestProtocol: String, numberOfRequests: Int) {
        self.port = port
        self.requestProtocol = requestProtocol
        self.numberOfRequests = numberOfRequests
    }
    
    private enum CodingKeys : String, CodingKey {
        case port, requestProtocol = "protocol", numberOfRequests
    }
}
