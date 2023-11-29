# mountebankSwift

A swift package for interacting with mountebank.


## Contents
The package currently supports the following: 
- Creating HttpImposters
- Removing all created imposters
- Retrieving all created imposters

## In the works
Currently being planned / developed are:
- Retrieving requests made to an endpoint
- Creating helpers to make creating request and response bodies easier
- Creating a `mockEndpoint` to make it easier to track requests.

## Using mountebankSwift
### Adding to an Xcode project
To add mountebankSwift to an Xcode project, follow the instructions [here](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app).

### Adding to a swift package project.
To include mountebankSwift in a swift package, it will need to be set up as a package dependency: 
```swift
// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ExamplePackage",
    products: [
        .library(
            name: "ExamplePackage",
            targets: ["ExamplePackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/dave-t-c/mountebankSwift.git", revision: "0.1")
    ],
    targets: [
        .target(
            name: "ExamplePackage"),
        .testTarget(
            name: "ExamplePackageTests",
            dependencies: [
                "ExamplePackage",
                "mountebankSwift"
            ]),
    ]
)
```

## Examples
### Creating a HTTP Imposter
To create a http imposter, you need to create the http stub as detailed below.

*Please note* - the request / response bodies need to be passed in as JSON strings for now, however this will be improved in a later version

```swift
func createHttpImposter() async throws {
    let exampleRequestBody: SimpleRequestBody = SimpleRequestBody(
        exampleInt: 2,
        exampleBool: false,
        exampleString: "test")
    let jsonRequestData: Data = try JSONEncoder().encode(exampleRequestBody)
    let jsonRequestBodyString = String(data: jsonRequestData, encoding: .utf8)

    let predicateHttpFields = HttpFields(
        path: "/v1/test",
        method: .POST,
        body: jsonRequestBodyString)
    let equalsPredicate = EqualsPredicate(equals: predicateHttpFields)
    let predicates = [equalsPredicate]

    let expectedStatusCode: Int = 201
    let httpResponseFields = HttpResponseFields(statusCode: expectedStatusCode)
    let response = IsResponse(isResponse: httpResponseFields)
    let responses = [response]

    let httpStub = HttpStub(predicates: predicates, responses: responses)
    let httpStubs = [httpStub]

    let mountebankClient = MountebankClient(mountebankUrl: "http://localhost:2525")
    try await mountebankClient.createHttpImposterAsync(port: 2526, stubs: httpStubs)
}
```

### Creating a HTTP Imposter with a response body
This is similar to the above, however you can pass in response headers / response body that are otherwise optional.
```swift
func createHttpImposter() async throws {
    let predicateHttpFields = HttpFields(
        path: "/v1/test",
        method: .GET)
    let equalsPredicate = EqualsPredicate(equals: predicateHttpFields)
    let predicates = [equalsPredicate]

    let expectedResponse: [Int] = [1, 2, 3]
    let bodyData = try JSONEncoder().encode(expectedResponse)
    let bodyJsonString = String(data: bodyData, encoding: .utf8)

    let responseHeaders = ["content-Type": "application/json"]
    let expectedStatusCode: Int = 200
    let httpResponseFields = HttpResponseFields(
        statusCode: expectedStatusCode,
        headers: responseHeaders,
        body: bodyJsonString)
    let response = IsResponse(isResponse: httpResponseFields)
    let responses = [response]
    let httpStub = HttpStub(predicates: predicates, responses: responses)
    let httpStubs = [httpStub]

    let mountebankClient = MountebankClient(mountebankUrl: "http://localhost:2525")
    try await mountebankClient.createHttpImposterAsync(port: 2526, stubs: httpStubs)
}
```

#### Removing all created imposters
To remove all created imposters on a given port, use: 
```swift
func removeCreatedImposters() async throws {
    let mountebankClient = MountebankClient(mountebankUrl: "http://localhost:2525")
    try await mountebankClient.deleteImposterAsync(port: 2526)
}
```

#### Retrieving all created imposters
To retrieve all of the imposters that have been created, use: 
```swift
func retrieveCreatedImposters() async throws {
    let mountebankClient = MountebankClient(mountebankUrl: "http://localhost:2525")
    let retrievedImposters = try await mountebankClient.retrieveCreatedImpostersAsync()
}
```
For each imposter, this will return the `port`, `protocol` and `numberOfRequests`.

*Please note*: requests are not currently recorded but this will be included in a later version.