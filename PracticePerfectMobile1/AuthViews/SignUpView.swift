//
//  SignUpView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var email: String = "initial"
    @State var password: String = "initial"
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
                    if (error != "") {
                        Text(error)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red)
                    }
                    
                    CustomTextField(
                        placeholder: Text("Email").foregroundColor(.gray).font(.system(size: 20)),
                        text: $email
                    ).onAppear(perform: {self.email = ""})
                    
                    CustomSecureField(
                        placeholder: Text("Password").foregroundColor(.gray).font(.system(size: 20)),
                        text: $password
                    ).onAppear(perform: {self.password = ""})
                    
                    
                    
                }
                    
                Button(action: signUp) {
                    Text("Create Account")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                }
        
            }.padding(.horizontal, 32)
            
        }
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
