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
    @State var confirmPassword = "initial"
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                Image("PracticePerfectLogo")
                    .resizable()
                    .frame(width: 105, height: 105)
                
                VStack(spacing: 15) {
                    
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
                    
                    CustomSecureField(
                        placeholder: Text("Confirm Password").foregroundColor(.gray).font(.system(size: 20)),
                        text: $confirmPassword
                    ).onAppear(perform: {self.confirmPassword = ""})
                }
                .padding(.vertical, 40)
                
                Button(action: signUp) {
                    Text("CREATE ACCOUNT")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                }
                
                Text("or...").foregroundColor(.white).padding(5)
                
                Button(action: { self.presentationMode.wrappedValue.dismiss() }){
                    Text("BACK TO LOGIN")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.secondary)
                        .cornerRadius(5)
                }
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }.modifier(DismissingKeyboard())
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
