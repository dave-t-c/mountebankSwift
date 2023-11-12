//
//  MountebankClient.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

/// Mountebank client for setting up imposters
class MountebankClient {
    var mountebankUrl = "http://localhost:2525"
    var requestWrapper: MountebankRequestWrapper
    
    init(mountebankUrl: String) {
        self.mountebankUrl = mountebankUrl
        self.requestWrapper = MountebankRequestWrapper(mountebankUrl: mountebankUrl)
    }
    
    func CreateHttpImposter(port: Int, stubs: [HttpStub]) async throws -> Void {
        let httpImposter = HttpImposter(port: port, stubs: stubs)
        print("Creating new HTTP imposter on port \(port)")
        try await self.requestWrapper.CreateImposterAsync(imposter: httpImposter)
    }
    
    func DeleteImposter(port: Int) async throws -> Void{
        try await self.requestWrapper.DeleteImposterAsync(port: port)
    }
}
