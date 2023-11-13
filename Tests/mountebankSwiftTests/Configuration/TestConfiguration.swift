//
//  TestConfiguration.swift
//
//
//  Created by David Cook on 13/11/2023.
//

import Foundation

struct TestConfiguration: Decodable {
    let baseRequestPath: String
    let relativeRequestPath: String
    let mountebankUrl: String
    let defaultTestPort: Int
}
