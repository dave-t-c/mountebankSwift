//
//  Constants.swift
//
//
//  Created by David Cook on 25/11/2023.
//

import Foundation

struct Constants {
    struct ResponseCodes {
        static let successCreateImposterStatusCode: Int = 201
        static let successRetrieveImpostersStatusCode: Int = 200
        static let successRetrieveImposterStatusCode: Int = 200
    }

    struct ResponseHeaders {
        static let defaultJsonResponseHeaders = ["content-Type": "application/json"]
    }
}
