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
    @State var practiceRoutines:Array<PracticeRoutine> = []
    @EnvironmentObject var firebaseController: FirebaseController
    
    var body: some View {
        NavigationView {
            ZStack {
                //Color.surface.edgesIgnoringSafeArea(.all)
                ScrollView {
                    //This will ForEach all of the lists
                    ForEach(self.firebaseController.practiceRoutines) { practiceRoutine in
                        NavigationLink(destination: SingleRoutineView(practiceRoutine: practiceRoutine)){
                        CardView(practiceRoutine: practiceRoutine)
                        }
                    }
                }
            }
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

