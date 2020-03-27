import XCTest
@testable import Session

final class LoginServiceTests: XCTestCase {

    var sut: LoginService!

    override func setUp() {
        sut = LoginService(url: URL(string: "https://example.com/")!)
    }

    override func tearDown() {
        sut = nil
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

    static var allTests = [
        ("testRequestShouldHaveURL", testRequestShouldHaveURL),
        ("testRequestShouldSetMethod", testRequestShouldSetMethod),
        ("testRequestShouldSetContentType", testRequestShouldSetContentType),
        ("testRequestShouldSetBody", testRequestShouldSetBody)
    ]

}

private extension LoginService.Input {
    static var test: Self {
        .init(email: "user@example.com", password: "password")
    }
}
