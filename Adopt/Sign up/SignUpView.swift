//
//  SignUpView.swift
//  Adopt
//
//  Created by Damian Rzeszot on 29/12/2019.
//  Copyright © 2019 Damian Rzeszot. All rights reserved.
//

import SwiftUI
import UIKit

struct User {

}

struct SignUp {
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

}



struct SignUpView: View {
    var action: (User) -> Void = { _ in }

    @State
    var email: String = "damian.rzeszot+1@gmail.com"

    @State
    var password: String = "qwerty"

    var body: some View {
        VStack {
            TextField("E-mail", text: $email)
            TextField("Password", text: $password)
            Button(action: {
                self.register { result in
                    print("register | \(result)")

                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            self.action(User())
                        }
                        break
                    case .failure:
                        break
                    }
                }
            }, label: {
                Text("Sign Up")
            })
        }
    }

    func register(completion: @escaping (SignUp.Response) -> Void) {
        print("sign up | loading")

        var request = URLRequest(url: URL(string: "https://adopt.rzeszot.pro/api/auth/sign_up")!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(SignUp.Request(user: SignUp.Request.User(email: email, password: password)))
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            print("sign up | done")

            if let response = response as? HTTPURLResponse {
                if response.statusCode == 400 {
                    completion(.failure(.invalid))
                    return
                }
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(SignUp.Success.self, from: data)
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


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
