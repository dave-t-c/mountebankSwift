//
//  RetrieveImpostersResponse.swift
//
//
//  Created by David Cook on 27/11/2023.
//

import Foundation

internal class RetrieveImpostersResponse: Codable {
    let imposters: [SimpleRetrievedImposter]

    init(imposters: [SimpleRetrievedImposter]) {
        self.imposters = imposters
    }
}
