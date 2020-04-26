//
//  ContentView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @State private var selected = 1
    @State private var loaded: Bool = false

    var ref: DatabaseReference! = Database.database().reference()
    
    func getUser() {
        //Promisify this
        session.listen()
        self.loaded = true
        // Firebase test
        self.ref.child("users").child("test").setValue(["username" : "TEST"])
    }
    
    
    // Sets the bottom tab background color
    init(){
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "card")
    }
    
    var body: some View {
        Group {
            if (self.loaded == false){
                Text("loading...")
            }
            
            else if (session.session != nil) {
                TabView(selection: $selected) {
                    HomeView()
                        .tabItem({
                            Image(systemName: "music.house.fill").foregroundColor(.white)
                            Text("Home")
                        }).tag(0).foregroundColor(.white)
                    
                    MyRoutinesView()
                        .tabItem({
                            Image(systemName: "music.note.list")
                            Text("My Routines")
                        }).tag(1)
                    
                    MetronomeView()
                        .tabItem({
                            Image(systemName: "music.note")
                            Text("Tools")
                        }).tag(2)
                    
                    SettingsView()
                        .tabItem({
                            Image(systemName: "gear")
                            Text("Settings")
                        }).tag(3)
                    
                }
                .background(Color.black)
                .accentColor(Color.primary)
                .font(.headline)
            } else if (self.loaded == true && session.session == nil) {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

// Gets colors from assets
extension Color {
    static let primary = Color("primary")
    static let secondary = Color("secondary")
    static let surface = Color("surface")
    static let card = Color("card")
    static let cardShadow = Color("cardShadow")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
