//
//  ContentView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selected = 1
    
    // Sets the bottom tab background color
    init(){
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(named: "card")
    }
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView()
                .tabItem({
                    Image(systemName: "music.house.fill")
                    Text("Home")
                }).tag(0)
            
            MyRoutinesView()
                .tabItem({
                    Image(systemName: "music.note.list")
                    Text("My Routines")
                }).tag(1)
            
            SettingsView()
                .tabItem({
                    Image(systemName: "gear")
                    Text("Settings")
                }).tag(2)
        }
        .background(Color.black)
        .accentColor(Color.primary)
        .font(.headline)
    }
}

// Gets colors from assets
extension Color {
    static let primary = Color("primary")
    static let secondary = Color("secondary")
    static let surface = Color("surface")
    static let card = Color("card")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
