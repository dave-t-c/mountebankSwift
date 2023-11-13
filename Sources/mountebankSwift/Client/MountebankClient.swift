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
    
    func createHttpImposterAsync(port: Int, stubs: [HttpStub]) async throws -> Void {
        let httpImposter = HttpImposter(port: port, stubs: stubs)
        print("Creating new HTTP imposter on port \(port)")
        try await self.requestWrapper.dreateImposterAsync(imposter: httpImposter)
    }
    
    func deleteImposterAsync(port: Int) async throws -> Void{
        try await self.requestWrapper.deleteImposterAsync(port: port)
    }
}
