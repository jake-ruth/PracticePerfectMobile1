//
//  PlayRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/14/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct PlayRoutineView: View {
    var practiceItems: PracticeItems
    @State var practiceItemIndex: Int = 0
    @State var minutes: Int = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(self.practiceItems.practiceItemsStored[self.practiceItemIndex].title!).font(.title)
            Text("\(self.minutes) seconds left").onReceive(timer) { input in

                if (self.minutes != 0){
                    self.minutes -= 1
                } else {
                    self.practiceItemIndex += 1
                    self.minutes = self.practiceItems.practiceItemsStored[self.practiceItemIndex].minutes as! Int
                }
            }
        }.onAppear(perform: {self.minutes = self.practiceItems.practiceItemsStored[self.practiceItemIndex].minutes as! Int})
    }
}

//struct PlayRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayRoutineView(practiceItems: PracticeItems())
//    }
//}

