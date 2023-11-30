//
//  MountebankClient.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

/// Mountebank client for setting up imposters
public class MountebankClient {
    var mountebankUrl: String
    var requestWrapper: MountebankRequestWrapper

    public init(mountebankUrl: String) {
        self.mountebankUrl = mountebankUrl
        self.requestWrapper = MountebankRequestWrapper(mountebankUrl: mountebankUrl)
    }

    /// Create a new http imposter for the given stubs
    public func createHttpImposterAsync(port: Int, stubs: [HttpStub], name: String? = nil) async throws {
        let httpImposter = HttpImposter(port: port, stubs: stubs, name: name)
        print("Creating new HTTP imposter on port \(port)")
        try await self.requestWrapper.createImposterAsync(imposter: httpImposter)
    }

    /// Deletes an imposter on the given port
    public func deleteImposterAsync(port: Int) async throws {
        try await self.requestWrapper.deleteImposterAsync(port: port)
    }

    /// Retrieves all created imposters
    public func retrieveCreatedImpostersAsync() async throws -> [SimpleRetrievedImposter] {
        return try await self.requestWrapper.retreiveCreatedImpostersAsync()
    }

    /// Retrieves the requests made to a Http Imposter
    public func retrieveHttpImposterAsync(port: Int) async throws -> RetrievedHttpImposter {
        let imposterData = try await self.requestWrapper.retrieveImposterAsync(port: port)
        do {
            let retrievedImposter = try JSONDecoder().decode(RetrievedHttpImposter.self, from: imposterData)
            return retrievedImposter
        } catch {
            print("Unable to cast response to http imposter: \(error)")
            throw MountebankExceptions.unableToRetrieveImposter
        }
    }
}
