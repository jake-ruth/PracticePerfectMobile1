//
//  SignUpView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
                
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.surface.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Create Account")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundColor(Color(.white))
                
                VStack(spacing: 18) {
                    TextField("Email address", text: $email)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 14))
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                }.padding(.vertical, 64)
                
                Button(action: signUp) {
                    Text("Create Account")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                    
                }
                
                if (error != ""){
                    Text(error)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.red)
                        .padding()
                }
                
                Spacer()
            }.padding(.horizontal, 32)
            
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
