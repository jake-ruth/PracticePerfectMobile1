//
//  PlayRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/14/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct PlayRoutineView: View {
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @State var practiceItemIndex: Int = 0
    @State var currentDate:Date = Date() + 10
    @State var showAlert: Bool = false
    @State var maxIndex: Int = 1
    
    var body: some View {
        VStack {
            Text(self.practiceItemsStored[self.practiceItemIndex].title!).font(.title)
//            CountdownView(practiceItemIndex: self.$practiceItemIndex, maxIndex: self.$maxIndex, referenceDate: Date() + TimeInterval((self.practiceItemsStored[practiceItemIndex].minutes as! Int)))
            
            CountdownView(practiceItemIndex: self.$practiceItemIndex, maxIndex: self.$maxIndex, referenceDate: self.$currentDate)
        }
    }
}

struct PlayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        PlayRoutineView()
    }
}

