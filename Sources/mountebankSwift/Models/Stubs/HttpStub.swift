//
//  HttpStub.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class HttpStub: Stub {
    let predicates: [EqualsPredicate]
    let responses: [IsResponse]
}
