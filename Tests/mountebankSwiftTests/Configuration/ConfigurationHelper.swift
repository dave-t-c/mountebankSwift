//
//  ConfigurationHelper.swift
//
//
//  Created by David Cook on 13/11/2023.
//

import Foundation

class ConfigurationHelper {

    static func importTestConfiguration() throws -> TestConfiguration? {
        let testConfigurationPath = Bundle.module.url(
            forResource: "TestConfiguration",
            withExtension: "json",
            subdirectory: "TestResources")
        let testConfigurationData = try Data(contentsOf: URL(fileURLWithPath: testConfigurationPath!.path()))
        return try JSONDecoder().decode(TestConfiguration.self, from: testConfigurationData)
    }

}
