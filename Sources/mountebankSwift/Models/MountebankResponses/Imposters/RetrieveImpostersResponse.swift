//
//  RetrieveImpostersResponse.swift
//
//
//  Created by David Cook on 27/11/2023.
//

import Foundation

class RetrieveImpostersResponse: Codable {
    let imposters: [RetrievedImposter]

    init(imposters: [RetrievedImposter]) {
        self.imposters = imposters
    }
}
