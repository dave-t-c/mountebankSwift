import XCTest
@testable import mountebankSwift

final class httpImposterTests: XCTestCase {
    var mountebankClient: MountebankClient?
    var requestHelper: RequestHelper?
    let testPort: Int = 2526
    let baseRequestPath: String = "http://localhost"
    
    override func setUp() async throws {
        mountebankClient = MountebankClient(mountebankUrl: "http://localhost:2525")
        requestHelper = RequestHelper()
    }
    
    override func tearDown() async throws{
        try await mountebankClient?.DeleteImposter(port: testPort)
    }
    
    func testCreateHttpImposter() async throws{
        let relativeRequestPath = "/v1/test"
        let predicateHttpFields = HttpFields(path: relativeRequestPath, method: .GET)
        let equalsPredicate = EqualsPredicate(equals: predicateHttpFields)
        let predicates = [equalsPredicate]
        
        let expectedResponse: [Int] = [1,2,3]
        let bodyData = try JSONEncoder().encode(expectedResponse)
        let bodyJsonString = String(data: bodyData, encoding: .utf8)
        
        let responseHeaders = ["content-Type": "application/json"]
        let expectedStatusCode: Int = 200
        let httpResponseFields = HttpResponseFields(statusCode: expectedStatusCode, headers: responseHeaders, body: bodyJsonString)
        let response = IsResponse(isResponse: httpResponseFields)
        let responses = [response]
        let httpStub = HttpStub(predicates: predicates, responses: responses)
        let httpStubs = [httpStub]
        try await mountebankClient?.CreateHttpImposter(port: testPort, stubs: httpStubs)
        
        let requestPath = "\(baseRequestPath):\(testPort)\(relativeRequestPath)"

        let (responseData, responseCode) = try await requestHelper!.MakeRequestToMockAsync(requestPath: requestPath, method: .GET)!
        XCTAssertNotNil(responseData)
        XCTAssertNotNil(responseCode)
        
        XCTAssertEqual(expectedStatusCode, responseCode)
        
        let actualResponse = try JSONDecoder().decode([Int].self, from: responseData!)
        
        XCTAssertEqual(expectedResponse, actualResponse)
    }
}
