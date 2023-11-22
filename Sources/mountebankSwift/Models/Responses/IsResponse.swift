//
//  IsResponse.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class IsResponse: Response {
    let isResponse: HttpResponseFields
    
    init(isResponse: HttpResponseFields) {
        self.isResponse = isResponse
    }
    
    private enum CodingKeys : String, CodingKey {
        case isResponse = "is"
    }
}
