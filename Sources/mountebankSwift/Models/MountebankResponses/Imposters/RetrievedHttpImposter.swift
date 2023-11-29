//
//  RetrievedHttpImposter.swift
//
//
//  Created by David Cook on 29/11/2023.
//

import Foundation

class RetrievedHttpImposter: RetrievedImposter {
    var requests: [HttpRequest]

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.requests = try container.decode([HttpRequest].self, forKey: .requests)
        try super.init(from: decoder)
    }

    private enum CodingKeys: String, CodingKey {
        case requests
    }
}
