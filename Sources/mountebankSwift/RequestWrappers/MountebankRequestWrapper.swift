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

    func deleteImposterAsync(port: Int) async throws {
        guard let url = URL(string: "\(self.mountebankUrl)/imposters/\(port)") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        print("Calling \(request.httpMethod!) \(request.url!)")

        _ = try await URLSession.shared.data(for: request)
    }

    func createImposterAsync(imposter: Imposter) async throws {
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
            print(Constants.ExceptionMessages.invalidResponseRecievedFromServerMessage)
            return
        }

        if httpResponse.statusCode != Constants.ResponseCodes.successCreateImposterStatusCode {
            print("Unable to create imposter, \(httpResponse.statusCode) returned")
            throw MountebankExceptions.unableToCreateImposter
        }
    }

    func retreiveCreatedImpostersAsync() async throws -> [SimpleRetrievedImposter] {
        guard let url = URL(string: "\(self.mountebankUrl)/imposters") else {
            throw MountebankExceptions.unableToRetrieveImposters
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            print(Constants.ExceptionMessages.invalidResponseRecievedFromServerMessage)
            throw MountebankExceptions.unableToRetrieveImposters
        }

        if httpResponse.statusCode != Constants.ResponseCodes.successRetrieveImpostersStatusCode {
            print("Unable to retrive created imposters")
            throw MountebankExceptions.unableToRetrieveImposters
        }

        do {
            let retrievedImposters = try JSONDecoder().decode(RetrieveImpostersResponse.self, from: data)
            return retrievedImposters.imposters
        } catch {
            print("Unable to cast response to imposter: \(error)")
            throw MountebankExceptions.unableToRetrieveImposters
        }
    }

    func retrieveImposterAsync(port: Int) async throws -> Data {
        guard let url = URL(string: "\(self.mountebankUrl)/imposters/\(port)") else {
            throw MountebankExceptions.unableToRetrieveImposter
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            print(Constants.ExceptionMessages.invalidResponseRecievedFromServerMessage)
            throw MountebankExceptions.unableToRetrieveImposter
        }

        if httpResponse.statusCode != Constants.ResponseCodes.successRetrieveImpostersStatusCode {
            print("Unable to retrive imposter for \(url.absoluteString)")
            throw MountebankExceptions.unableToRetrieveImposter
        }

        return data
    }
}
