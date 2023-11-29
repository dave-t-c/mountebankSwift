//
//  MockHelper.swift
//
//
//  Created by David Cook on 25/11/2023.
//

import Foundation
@testable import mountebankSwift

class MockHelper {
    func createBasicHttpMockAsync(
        configuration: TestConfiguration?,
        mountebankClient: MountebankClient?,
        expectedStatusCode: Int,
        expectedResponse: Codable) async throws{
        let predicateHttpFields = HttpFields(path: configuration!.relativeRequestPath, method: .GET)
        let equalsPredicate = EqualsPredicate(equals: predicateHttpFields)
        let predicates = [equalsPredicate]

        let bodyData = try JSONEncoder().encode(expectedResponse)
        let bodyJsonString = String(data: bodyData, encoding: .utf8)

        let responseHeaders = Constants.ResponseHeaders.defaultJsonResponseHeaders
        let httpResponseFields = HttpResponseFields(statusCode: expectedStatusCode, headers: responseHeaders, body: bodyJsonString)
        let response = IsResponse(isResponse: httpResponseFields)
        let responses = [response]
        let httpStub = HttpStub(predicates: predicates, responses: responses)
        let httpStubs = [httpStub]
        try await mountebankClient?.createHttpImposterAsync(port: configuration!.defaultTestPort, stubs: httpStubs)
    }
}
