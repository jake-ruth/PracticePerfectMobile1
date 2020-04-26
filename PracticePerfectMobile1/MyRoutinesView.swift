//
//  MyRoutinesView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct MyRoutinesView: View {
    var practiceRoutines:Array<PracticeRoutine> = []
    
    init() {
        //Fetch routines from firebase eventually
        let practiceRoutine1 = PracticeRoutine()
        practiceRoutine1.routineTitle = "Jake's Routine"
        practiceRoutine1.practiceItems = ["First", "Second", "Third"]
        practiceRoutine1.uuid = UUID()
        practiceRoutine1.isFavorite = false
        
        let practiceRoutine2 = PracticeRoutine()
        practiceRoutine2.routineTitle = "Erika's Routine"
        practiceRoutine2.practiceItems = ["Buy cat", "kill racoon", "eat racoon"]
        practiceRoutine2.uuid = UUID()
        practiceRoutine2.isFavorite = false
        
        self.practiceRoutines.append(practiceRoutine1)
        self.practiceRoutines.append(practiceRoutine2)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.surface.edgesIgnoringSafeArea(.all)
                ScrollView {
                    //This will ForEach all of the lists
                    ForEach(0..<self.practiceRoutines.count) {
                        
                        CardView(practiceRoutine: self.practiceRoutines[$0])
                    }
                }
            }.navigationBarTitle(Text("My Routines").foregroundColor(Color.white), displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {print("filter")}) {
                        Image(systemName: "slider.horizontal.3")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                    },
                    trailing: Button(action: {print("Add item")}) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.white)
                })
        }
    }
}

struct MyRoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutinesView()
    }
}

