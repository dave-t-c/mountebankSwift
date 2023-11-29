//
//  EqualsPredicate.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class EqualsPredicate: Predicate {
    let equals: HttpFields

    init(equals: HttpFields) {
        self.equals = equals
    }
}
