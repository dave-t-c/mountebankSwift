//
//  IsResponse.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

public class IsResponse: Response {
    public let isResponse: HttpResponseFields

    public init(isResponse: HttpResponseFields) {
        self.isResponse = isResponse
    }

    private enum CodingKeys: String, CodingKey {
        case isResponse = "is"
    }
}
