//
//  HttpStub.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

public class HttpStub: Stub {
    let predicates: [EqualsPredicate]
    let responses: [IsResponse]

    public init(predicates: [EqualsPredicate], responses: [IsResponse]) {
        self.predicates = predicates
        self.responses = responses
    }
}
