//
//  SimpleRequestBody.swift
//
//
//  Created by David Cook on 12/11/2023.
//

import Foundation

struct SimpleRequestBody: Codable {
    init(exampleInt: Int? = nil, exampleBool: Bool? = nil, exampleString: String? = nil) {
        self.exampleInt = exampleInt
        self.exampleBool = exampleBool
        self.exampleString = exampleString
    }
    
    let exampleInt: Int?
    let exampleBool: Bool?
    let exampleString: String?
}
