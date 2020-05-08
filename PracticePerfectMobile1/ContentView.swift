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
    @EnvironmentObject var firebaseController: FirebaseController
    @EnvironmentObject var navbarSettings: NavbarSettings
    @State var index = 0
    @State private var loaded: Bool = false
    
    var ref: DatabaseReference! = Database.database().reference()
    
    func getUser() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        session.listen()
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main){
        self.loaded = true
        }
    }
    
    var body: some View {
        Group {
            if (self.loaded == false){
                Text("Loading...")
            }
                
            else if (session.session != nil) {
                VStack {
                    
                    ZStack {
                        if (self.index == 0){
                            HomeView()
                        }
                        else if (self.index == 1){
                            MyRoutinesView().environmentObject(self.firebaseController).environmentObject(self.navbarSettings)
                        }
                        else if (self.index == 2){
                            MetronomeView()
                        }
                        else if (self.index == 3){
                            SettingsView()
                        }
                    }
                        
                    //Show navigation only when supposed to
                    self.navbarSettings.navbarVisible == true ? TabBar(index: $index) : nil
                    
                }.animation(.spring())
                
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
    static let card2 = Color("card2")
    static let test1 = Color("test1")
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //ContentView().environmentObject(SessionStore())
//    }
//}
