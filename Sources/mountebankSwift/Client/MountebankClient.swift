//
//  MountebankClient.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

/// Mountebank client for setting up imposters
class MountebankClient {
    var mountebankUrl: String
    var requestWrapper: MountebankRequestWrapper
    
    init(mountebankUrl: String) {
        self.mountebankUrl = mountebankUrl
        self.requestWrapper = MountebankRequestWrapper(mountebankUrl: mountebankUrl)
    }
    
    /// Create a new http imposter for the given stubs
    func createHttpImposterAsync(port: Int, stubs: [HttpStub]) async throws -> Void {
        let httpImposter = HttpImposter(port: port, stubs: stubs)
        print("Creating new HTTP imposter on port \(port)")
        try await self.requestWrapper.createImposterAsync(imposter: httpImposter)
    }
    
    /// Deletes an imposter on the given port
    func deleteImposterAsync(port: Int) async throws -> Void{
        try await self.requestWrapper.deleteImposterAsync(port: port)
    }
    
    /// Retrieves all created imposters
    func retrieveCreatedImpostersAsync() async throws -> [RetrievedImposter] {
        return try await self.requestWrapper.retreiveCreatedImpostersAsync()
    }
}
