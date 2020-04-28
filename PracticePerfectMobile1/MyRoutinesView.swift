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
        let practiceItem1 = NewPracticeItem()
        practiceItem1.uuid = UUID()
        practiceItem1.title = "Practice Scales"
        practiceItem1.details = "Practice in Every key"
        practiceItem1.minutes = 20
        
        let practiceItem2 = NewPracticeItem()
        practiceItem2.uuid = UUID()
        practiceItem2.title = "Practice Something"
        practiceItem2.details = "Practice in Every key"
        practiceItem2.minutes = 10
        
        let practiceItem3 = NewPracticeItem()
        practiceItem3.uuid = UUID()
        practiceItem3.title = "Practice Song"
        practiceItem3.details = "Practice in Every key"
        practiceItem3.minutes = 20
        
        //Fetch routines from firebase eventually
        let practiceRoutine1 = PracticeRoutine()
        practiceRoutine1.routineTitle = "Jake's Routine"
        practiceRoutine1.practiceItems = [practiceItem1, practiceItem2, practiceItem3]
        practiceRoutine1.uuid = UUID()
        practiceRoutine1.isFavorite = false
        
        let practiceRoutine2 = PracticeRoutine()
        practiceRoutine2.routineTitle = "Erika's Routine"
        practiceRoutine2.practiceItems = [practiceItem1, practiceItem3]
        practiceRoutine2.uuid = UUID()
        practiceRoutine2.isFavorite = false
        
        self.practiceRoutines.append(practiceRoutine1)
        self.practiceRoutines.append(practiceRoutine2)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                //Color.surface.edgesIgnoringSafeArea(.all)
                ScrollView {
                    //This will ForEach all of the lists
                    ForEach(self.practiceRoutines) { practiceRoutine in
                        NavigationLink(destination: Text(practiceRoutine.routineTitle!)){
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

