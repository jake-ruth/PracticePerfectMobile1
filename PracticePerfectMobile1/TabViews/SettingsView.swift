//
//  SettingsView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @EnvironmentObject var session: SessionStore
    @State private var pauseBetweenItems = true
    
    var body: some View {
        NavigationView {
        ZStack {
            VStack {
                
                List{
                    HStack {
                        Text("Email: " + (Auth.auth().currentUser?.email)!).foregroundColor(.white)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(Color.primary)
                            .font(.system(size: 20, weight: .heavy))
                    }.padding(.horizontal)
                    
                    HStack {
                        Toggle("", isOn: $pauseBetweenItems)
                            .toggleStyle(
                                ColoredToggleStyle(label: "Pause between items", onColor: Color.primary))
                    }.listRowBackground(Color.surface)
                }.navigationBarTitle(Text("Settings").foregroundColor(Color.white), displayMode: .inline)
                
                Button(action: session.signOut) {
                    Text("Sign Out")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.secondary)
                        .cornerRadius(5)
                        .padding()
                }
            }
        }
        }
    }
}

struct ColoredToggleStyle: ToggleStyle {
    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Text(label)
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .padding(.horizontal)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

