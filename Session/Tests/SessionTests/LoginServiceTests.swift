import XCTest
@testable import Session


final class LoginServiceTests: XCTestCase {

    private var session: MockURLSession!

    var sut: LoginService!

    override func setUp() {
        session = MockURLSession()
        sut = LoginService(url: URL(string: "https://example.com/")!, session: session)
    }

    override func tearDown() {
        session = nil
        sut = nil
    }

    // MARK: -

    func testPerformSuccess() {
        session.handler = { request in
            let payload = """
                {
                    "token": "12345"
                }
                """
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)

            return (payload.data(using: .utf8), response, nil)
        }

        let output = perform(input: .test)

        XCTAssertNotNil(output)
        XCTAssertNoThrow(try output?.get())
        XCTAssertEqual(try? output?.get().token, "12345")
    }

    func testPerformFailureInvalid() {
        session.handler = { request in
            let payload = ""
            let response = HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: nil, headerFields: nil)

            return (payload.data(using: .utf8), response, nil)
        }

        let output = perform(input: .test)

        guard case .failure(let error)? = output else { XCTFail(); return }
        guard case .invalid = error else { XCTFail(); return }
    }

    func testPerformFailureUnknown() {
        session.handler = { request in
            let payload = ""
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)

            return (payload.data(using: .utf8), response, nil)
        }

        let output = perform(input: .test)

        guard case .failure(let error)? = output else { XCTFail(); return }
        guard case .unknown = error else { XCTFail(); return }
    }

    // MARK: -

    func testRequestShouldHaveURL() {
        let request = sut.request(for: .test)

        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url, sut.url)
    }

    func testRequestShouldSetMethod() {
        let request = sut.request(for: .test)

        XCTAssertNotNil(request.httpMethod)
        XCTAssertEqual(request.httpMethod, "POST")
    }

    func testRequestShouldSetContentType() {
        let request = sut.request(for: .test)

        XCTAssertNotNil(request.allHTTPHeaderFields)
        XCTAssertEqual(request.allHTTPHeaderFields?["Content-Type"], "application/json")
    }

    func testRequestShouldSetBody() {
        let request = sut.request(for: .test)

        XCTAssertNotNil(request.httpBody)
        XCTAssertEqual(request.httpBody.map { String(data: $0, encoding: .utf8) }, """
            {
              "email" : "user@example.com",
              "password" : "password"
            }
            """)
    }

    // MARK: -

    private func perform(input: LoginService.Input) -> LoginService.Output? {
        var result: LoginService.Output?

        let exp = expectation(description: "")
        sut.perform(email: .email, password: .password) { output in
            result = output
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
        return result
    }

    // MARK: -

    static var allTests = [
        ("testRequestShouldHaveURL", testRequestShouldHaveURL),
        ("testRequestShouldSetMethod", testRequestShouldSetMethod),
        ("testRequestShouldSetContentType", testRequestShouldSetContentType),
        ("testRequestShouldSetBody", testRequestShouldSetBody)
    ]

}

private extension String {
    static var email = "user@example.com"
    static var password = "password"
}

private extension LoginService.Input {
    static var test = LoginService.Input(email: .email, password: .password)
}
