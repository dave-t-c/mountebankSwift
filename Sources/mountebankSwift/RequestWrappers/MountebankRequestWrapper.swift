//
//  MountebankRequestWrapper.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation

class MountebankRequestWrapper {
    var mountebankUrl: String
    
    init(mountebankUrl: String) {
        self.mountebankUrl = mountebankUrl
    }
    
    func deleteImposterAsync(port: Int) async throws -> Void {
        guard let url = URL(string: "\(self.mountebankUrl)/imposters/\(port)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        print("Calling \(request.httpMethod!) \(request.url!)")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response recieved from server")
            return
        }
        
        if httpResponse.statusCode != 200{
            print("Unable to delete imposter, \(httpResponse.statusCode) returned")
            throw MountebankExceptions.unableToDeleteImposter
        }
    }
    
    func dreateImposterAsync(imposter: HttpImposter) async throws -> Void {
        guard let url = URL(string: "\(self.mountebankUrl)/imposters") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(imposter)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        print("Calling \(request.httpMethod!) \(request.url!)")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response recieved from server")
            return
        }
        
        if httpResponse.statusCode != 201{
            print("Unable to create imposter, \(httpResponse.statusCode) returned")
            throw MountebankExceptions.unableToCreateImposter
        }
    }
}
