//
//  HttpStub.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

struct HttpStub: Codable {
    let predicates: [EqualsPredicate]
    let responses: [IsResponse]
}
