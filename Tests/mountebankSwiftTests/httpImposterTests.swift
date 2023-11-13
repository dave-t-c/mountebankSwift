import XCTest
@testable import mountebankSwift

final class httpImposterTests: XCTestCase {
    var mountebankClient: MountebankClient?
    var requestHelper: RequestHelper?
    let testPort: Int = 2526
    var configuration: TestConfiguration?
    
    override func setUp() async throws {
        let testConfigurationPath = Bundle.module.url(forResource: "TestConfiguration", withExtension: "json", subdirectory: "TestResources")
        let data = try Data(contentsOf: URL(fileURLWithPath: testConfigurationPath!.path()))
        configuration = try JSONDecoder().decode(TestConfiguration.self, from: data)
        mountebankClient = MountebankClient(mountebankUrl: configuration!.mountebankUrl)
        requestHelper = RequestHelper()
    }
    
    override func tearDown() async throws{
        try await mountebankClient?.deleteImposterAsync(port: testPort)
    }
    
    func testCreateHttpImposter() async throws{
        let predicateHttpFields = HttpFields(path: configuration!.relativeRequestPath, method: .GET)
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
        try await mountebankClient?.createHttpImposterAsync(port: testPort, stubs: httpStubs)
        
        let requestPath = "\(configuration!.baseRequestPath):\(testPort)\(configuration!.relativeRequestPath)"

        let (responseData, responseCode) = try await requestHelper!.MakeRequestToMockAsync(requestPath: requestPath, method: .GET)!
        XCTAssertNotNil(responseData)
        XCTAssertNotNil(responseCode)
        
        XCTAssertEqual(expectedStatusCode, responseCode)
        
        let actualResponse = try JSONDecoder().decode([Int].self, from: responseData!)
        
        XCTAssertEqual(expectedResponse, actualResponse)
    }
    
    func testCreateHttpImposterWithRequestBody() async throws {
        let exampleRequestBody = SimpleRequestBody(exampleInt: 2, exampleBool: false, exampleString: "test")
        let jsonRequestData = try JSONEncoder().encode(exampleRequestBody)
        let jsonRequestBodyString = String(data: jsonRequestData, encoding: .utf8)
        let predicateHttpFields = HttpFields(path: configuration!.relativeRequestPath, method: .POST, body: jsonRequestBodyString)
        let equalsPredicate = EqualsPredicate(equals: predicateHttpFields)
        let predicates = [equalsPredicate]
        
        
        let expectedStatusCode: Int = 201
        let httpResponseFields = HttpResponseFields(statusCode: expectedStatusCode)
        let response = IsResponse(isResponse: httpResponseFields)
        let responses = [response]
        let httpStub = HttpStub(predicates: predicates, responses: responses)
        let httpStubs = [httpStub]
        try await mountebankClient?.createHttpImposterAsync(port: testPort, stubs: httpStubs)
        
        let requestPath = "\(configuration!.baseRequestPath):\(testPort)\(configuration!.relativeRequestPath)"

        let (_, responseCode) = try await requestHelper!.MakeRequestToMockAsync(requestPath: requestPath, method: .POST, requestBodyData: jsonRequestData)!
        XCTAssertNotNil(responseCode)
        
        XCTAssertEqual(expectedStatusCode, responseCode)
        
    }
}
