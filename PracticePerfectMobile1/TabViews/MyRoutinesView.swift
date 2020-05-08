//
//  MyRoutinesView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import Combine

struct MyRoutinesView: View {
    @EnvironmentObject var firebaseController: FirebaseController
    @EnvironmentObject var navbarSettings: NavbarSettings
    @State var selectedItemIndex: Int? = 2
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    if self.firebaseController.practiceRoutines.isEmpty {
                        Text("Click the plus icon to create a routine")
                    } else {
                        
                        ForEach(self.firebaseController.practiceRoutines.indices) { index in
                            NavigationLink(destination: SingleRoutineView(practiceRoutine: self.firebaseController.practiceRoutines[index]).environmentObject(self.firebaseController).environmentObject(self.navbarSettings),
                                           tag: index, selection: self.$selectedItemIndex){
                                            CardView(practiceRoutine: self.firebaseController.practiceRoutines[index])
                            }
                        }
                    }
                }
            }
            .onAppear(perform: {self.navbarSettings.navbarVisible = true})
            .navigationBarTitle(Text("My Routines").foregroundColor(Color.white), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {print("filter")}) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: 23, height: 23)
                        .foregroundColor(Color.white)
                },
                trailing: NavigationLink(destination: CreateRoutineView()) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.primary)
            })
        }.navigationViewStyle(StackNavigationViewStyle()).zIndex(0)
    }
}

struct MyRoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutinesView()
    }
}

