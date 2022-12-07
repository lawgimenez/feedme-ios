//
//  SignInView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct SignInView: View {
    
    @State private var signInSuccess = false
    @State private var isSigningIn = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            SecureField("Password", text: $password)
                .frame(width: 300)
                .disableAutocorrection(true)
                .padding(.bottom)
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
    }
    
    private func signIn() {
        if !email.isEmpty && !password.isEmpty {
            isSigningIn = true
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
