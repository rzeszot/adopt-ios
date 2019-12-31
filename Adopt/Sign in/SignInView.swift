//
//  SignInView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 31/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI

struct SignIn {
    struct Request: Codable {
        struct User: Codable {
            let email: String
            let password: String
        }
        let user: User
    }

    typealias Response = Result<Success, Failure>

    struct Success: Codable {
        let token: String
    }
    enum Failure: Error {
        case invalid
        case parsing(Error)
        case unknown
    }

    struct Data {
        let email: String
        let token: String
    }

}




struct SignInView: View {

    var action: (SignIn.Data) -> Void

    @State
    var email: String = "damian.rzeszot+1@gmail.com"

    @State
    var password: String = "qwerty"

    var body: some View {
        VStack {
            Text("Sign In")
                .font(.headline)

            TextField("E-mail", text: $email)
            TextField("Password", text: $password)

            Button(action: {
                self.login { result in
                    print("login | \(result)")

                    switch result {
                    case .success(let success):
                        DispatchQueue.main.async {
                            self.action(SignIn.Data(email: self.email, token: success.token))
                        }
                        break
                    case .failure:
                        break
                    }
                }
            }, label: {
                Text("Sign In")
            })
        }
    }

    func login(completion: @escaping (SignIn.Response) -> Void) {
        print("sign in | loading")

        var request = URLRequest(url: URL(string: "https://adopt.rzeszot.pro/api/auth/sign_in")!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(SignIn.Request(user: SignIn.Request.User(email: email, password: password)))
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            print("sign in | done")

            if let response = response as? HTTPURLResponse {
                if response.statusCode == 400 {
                    completion(.failure(.invalid))
                    return
                }
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(SignIn.Success.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.parsing(error)))
                }
            } else {
                completion(.failure(.unknown))
            }
        }

        task.resume()
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(action: { _ in })
    }
}
