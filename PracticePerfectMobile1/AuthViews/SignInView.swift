//
//  SignInView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = "initial"
    @State var password: String = "initial"
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
                }
                .padding(.vertical, 40)
                
                Button(action: signIn){
                    Text("SIGN IN")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                }
                
                Text("or...").foregroundColor(.white).padding(5)
                
                NavigationLink(destination: QuickRoutineView()){
                    Text("QUICK ROUTINE")
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
                        
                    }.padding(.bottom, 30)
                }
            }
            .padding(.horizontal, 32)
        }.modifier(DismissingKeyboard())
    }
}

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                let keyWindow = UIApplication.shared.connectedScenes
                        .filter({$0.activationState == .foregroundActive})
                        .map({$0 as? UIWindowScene})
                        .compactMap({$0})
                        .first?.windows
                        .filter({$0.isKeyWindow}).first
                keyWindow?.endEditing(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
