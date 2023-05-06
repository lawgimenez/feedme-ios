//
//  SignInView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct SignInView: View {
    
//    @State private var signInSuccess = false
    @State private var isSigningIn = false
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject private var authObservables: AuthObservables
    
    var body: some View {
        if authObservables.status == .success {
            HomeView()
                .environmentObject(authObservables)
        } else {
            VStack {
                TextField("Email Address", text: $email)
                    .frame(width: 300)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .padding([.top], 100)
                SecureField("Password", text: $password)
                    .frame(width: 300)
                    .disableAutocorrection(true)
                    .padding(.bottom)
                    .padding([.top], 25)
                Button(action: signIn) {
                    if isSigningIn {
                        ProgressView()
                            .background(Color.clear)
                            .frame(width: 200)
                            .tint(Color.white)
                    } else {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .frame(width: 200)
                            .padding(5)
                    }
                }
                .frame(width: 200, height: 45)
                .background(.green)
                .cornerRadius(10)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    private func signIn() {
        if !email.isEmpty && !password.isEmpty {
            print(String(format: "%@:%@", email, password))
            isSigningIn = true
            if let url = URL(string: Urls.Api.auth) {
                let userValue = String(format: "%@:%@", email, password).data(using: .utf8)?.base64EncodedString()
                let session = URLSession.shared
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("Basic \(userValue!)", forHTTPHeaderField: "Authorization")
                let task = session.dataTask(with: request) { _, response, error in
                    isSigningIn = false
                    if let error = error {
                        print("Sign In error = \(error)")
                    } else {
                        let statusResponse = response as! HTTPURLResponse
                        if statusResponse.statusCode == 200 {
                            print("Sign in success")
                            UserDefaults.standard.set(true, forKey: Keys.Auth.isSignedIn)
                            UserDefaults.standard.set(email, forKey: Keys.Auth.email)
                            UserDefaults.standard.set(password, forKey: Keys.Auth.password)
//                            signInSuccess = true
                            authObservables.status = .success
                        }
                    }
                }
                task.resume()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
