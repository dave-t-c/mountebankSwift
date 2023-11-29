//
//  RequestHelper.swift
//
//
//  Created by David Cook on 11/11/2023.
//

import Foundation
import XCTest
@testable import mountebankSwift

class RequestHelper {

    func buildRequestPath(
        baseRequestPath: String,
        testPort: Int,
        relativeRequestPath: String) -> String {
        return "\(baseRequestPath):\(testPort)\(relativeRequestPath)"
    }

    func makeRequestToMockAsync(requestPath: String, method: HttpMethod, requestBodyData: Data? = nil) async throws -> (Data?, Int?)? {

        guard let url = URL(string: requestPath) else {
            XCTFail("Unable to create a URL for path: \(requestPath)")
            return (nil, nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = String(describing: method)
        request.httpBody = requestBodyData

        print("Calling \(request.httpMethod!) \(request.url!)")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            return (nil, nil)
        }

        return (data, httpResponse.statusCode)
    }
}
