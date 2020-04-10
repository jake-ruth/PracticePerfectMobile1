//
//  SignInView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func signIn() {
        session.signIn(email: email, password: password) { (result, error) in
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
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110.0, height: 110, alignment: .top)
                
                VStack(spacing: 18) {
                    if (error != "") {
                        Text(error)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.red)
                        
                        
                    }
                    TextField("Email address", text: $email)
                        .font(.system(size: 20))
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                        .foregroundColor(Color(.white))
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 20))
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                        .foregroundColor(Color(.white))
                    
                }
                .padding(.vertical, 50)
                
                Button(action: signIn){
                    Text("Sign in")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                }
                
                Text("or...").foregroundColor(.white).padding()
                
                NavigationLink(destination: QuickRoutineView()){
                    Text("Quick Routine")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.secondary)
                        .cornerRadius(5)
                }
                
                Spacer()
                
                NavigationLink(destination: SignUpView()) {
                    HStack {
                        Text("New user?")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white)
                        
                        Text("Create an account")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        
                    }.padding()
                }
            }
            .padding(.horizontal, 32)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
