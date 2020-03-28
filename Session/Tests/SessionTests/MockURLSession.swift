//
//  Copyright © 2020 Damian Rzeszot. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    let completion: () -> Void

    init(completion: @escaping () -> Void) {
        self.completion = completion
    }

    override func resume() {
        completion()
    }
}

class MockURLSession: URLSession {
    typealias Handler = (URLRequest) -> (Data?, URLResponse?, Error?)

    var handler: Handler?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let (data, response, error) = handler!(request)

        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
}
