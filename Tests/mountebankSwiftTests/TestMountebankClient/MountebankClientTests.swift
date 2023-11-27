//
//  MountebankClientTests.swift
//  
//
//  Created by David Cook on 23/11/2023.
//

import XCTest
@testable import mountebankSwift

final class MountebankClientTests: XCTestCase {
    
    var mountebankClient: MountebankClient?
    var requestHelper: RequestHelper?
    var mockHelper: MockHelper?
    var configuration: TestConfiguration?
    
    override func setUp() async throws {
        configuration = try ConfigurationHelper.importTestConfiguration()
        mountebankClient = MountebankClient(mountebankUrl: configuration!.mountebankUrl)
        requestHelper = RequestHelper()
        mockHelper = MockHelper()
    }
    
    override func tearDown() async throws{
        try await mountebankClient?.deleteImposterAsync(port: configuration!.defaultTestPort)
    }

    /** Create a basic imposter */
    func testCreateImposter() async throws {
        let expectedStatusCode: Int = 200
        let expectedResponse: [Int] = [1,2,3]
        
        try await mockHelper!.createBasicHttpMockAsync(
            configuration: configuration,
            mountebankClient: mountebankClient,
            expectedStatusCode: expectedStatusCode,
            expectedResponse: expectedResponse)
        
        let requestPath = requestHelper!.buildRequestPath(
            baseRequestPath: configuration!.baseRequestPath,
            testPort: configuration!.defaultTestPort,
            relativeRequestPath: configuration!.relativeRequestPath)

        let (responseData, responseCode) = try await requestHelper!.makeRequestToMockAsync(requestPath: requestPath, method: .GET)!
        XCTAssertNotNil(responseData)
        XCTAssertNotNil(responseCode)
        
        XCTAssertEqual(expectedStatusCode, responseCode)
        
        let actualResponse = try JSONDecoder().decode([Int].self, from: responseData!)
        
        XCTAssertEqual(expectedResponse, actualResponse)
    }
    
    /** Create a duplicate imposter where one has already been created */
    func testCreateImposterAlreadyExists() async throws {
        let expectedStatusCode: Int = 200
        let expectedResponse: [Int] = [1,2,3]
        
        try await mockHelper!.createBasicHttpMockAsync(
            configuration: configuration,
            mountebankClient: mountebankClient,
            expectedStatusCode: expectedStatusCode,
            expectedResponse: expectedResponse)
        
        let exceptionExpectation = expectation(description: "Error thrown creating duplicate mock")
        
        do {
            try await mockHelper!.createBasicHttpMockAsync(
                configuration: configuration,
                mountebankClient: mountebankClient,
                expectedStatusCode: expectedStatusCode,
                expectedResponse: expectedResponse)
            
        } catch MountebankExceptions.unableToCreateImposter {
            exceptionExpectation.fulfill()
        } catch {
            XCTFail("Unexpected exception thrown")
        }
        
        await fulfillment(of: [exceptionExpectation])
    }
    
    /** Delete an imposter*/
    func testDeleteImposter() async throws {
        let expectedStatusCode: Int = 200
        let expectedResponse: [Int] = [1,2,3]
        
        try await mockHelper!.createBasicHttpMockAsync(
            configuration: configuration,
            mountebankClient: mountebankClient,
            expectedStatusCode: expectedStatusCode,
            expectedResponse: expectedResponse)
        
        try await mountebankClient!.deleteImposterAsync(port: configuration!.defaultTestPort)
        
        let retrievedImposters = try await mountebankClient!.retrieveCreatedImpostersAsync()
        
        XCTAssertEqual(0, retrievedImposters.count)
    }
    
    /** Delete an imposter when a matching imposter has not been created */
    func testDeleteImposterNotCreated() throws {
        XCTFail()
    }
}
