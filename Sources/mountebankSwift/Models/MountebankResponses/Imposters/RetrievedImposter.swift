//
//  RetrievedImposter.swift
//
//
//  Created by David Cook on 29/11/2023.
//

import Foundation

public class RetrievedImposter: SimpleRetrievedImposter {
    var recordRequests: Bool

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.recordRequests = try container.decode(Bool.self, forKey: .recordRequests)
        try super.init(from: decoder)
    }

    private enum CodingKeys: String, CodingKey {
        case recordRequests
    }
}
