//
//  SignInView.swift
//  FeedMe
//
//  Created by Lawrence Gimenez on 12/7/22.
//

import SwiftUI

struct SignInView: View {
    
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
