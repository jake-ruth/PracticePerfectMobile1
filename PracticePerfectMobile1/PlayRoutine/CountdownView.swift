//
//  CountdownView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/17/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct CountdownView : View {
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @State private var nowDate: Date = Date()
    @Binding var practiceItemIndex: Int
    @Binding var maxIndex: Int
    @Binding var referenceDate: Date
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
            if (self.nowDate > self.referenceDate){
                if (self.practiceItemIndex < self.maxIndex){
                self.practiceItemIndex += 1
                    self.referenceDate = Date() + TimeInterval((self.practiceItemsStored[self.practiceItemIndex].minutes as! Int))
                }
                else {
                    print("Alert that routine is finished")
                }
            }

        }
    }
    
    var body: some View {
        Text(countDownString(from: referenceDate))
            .font(.largeTitle)
            .onAppear(perform: {
                _ = self.timer
            })
    }
    
    func countDownString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar
            .dateComponents([.minute, .second],
                            from: nowDate,
                            to: referenceDate)
        return String(format: "%02dm:%02ds",
                      components.minute ?? 00,
                      components.second ?? 00)
    }
}

//struct CountdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountdownView(practiceItemIndex: 0, referenceDate: Date())
//    }
//}
