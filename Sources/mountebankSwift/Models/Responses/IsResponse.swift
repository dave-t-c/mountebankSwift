//
//  IsResponse.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

struct IsResponse: Response {
    let isResponse: HttpResponseFields
    
    private enum CodingKeys : String, CodingKey {
        case isResponse = "is"
    }
}
