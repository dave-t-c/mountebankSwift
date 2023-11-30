//
//  EqualsPredicate.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

public class EqualsPredicate: Predicate {
    let equals: HttpFields

    public init(equals: HttpFields) {
        self.equals = equals
    }
}
