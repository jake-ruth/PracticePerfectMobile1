//
//  PlayRoutineViewTwo.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/18/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct PlayRoutineView: View {
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @State var practiceItemIndex: Int = 0
    @State var seconds: Int = 0
    @State var playing: Bool = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func incrementPracticeItemIndex() {
        if (self.practiceItemIndex < self.practiceItemsStored.count - 1) {
            self.practiceItemIndex += 1
            self.seconds = self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60
        }
    }
    
    func decrementPracticeItemIndex() {
        if (self.practiceItemIndex > 0) {
            self.practiceItemIndex -= 1
            self.seconds = self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60
        }
    }
    
    var body: some View {
            VStack {
                Text(self.practiceItemsStored[self.practiceItemIndex].title!).font(.title)
                Text(self.practiceItemsStored[self.practiceItemIndex].details!)
                Spacer()
                CountdownView(seconds: self.$seconds).onReceive(timer) { input in
                    if (self.seconds != 0){
                        if (self.playing == true){
                            self.seconds -= 1
                        }
                    } else {
                        self.practiceItemIndex += 1
                        self.seconds = self.practiceItemsStored[self.practiceItemIndex].minutes as! Int
                    }
                }
                Spacer()
                HStack {
                    Button(action: {self.decrementPracticeItemIndex()}) {
                        Image(systemName: "backward.fill").font(.system(size: 40, weight: .heavy))
                    }.padding()
                    Spacer()
                    Button(action: {self.playing.toggle()}) {
                        Image(systemName: self.playing ? "pause.circle" : "play.circle").font(.system(size: 60, weight: .heavy))
                    }.padding()
                    Spacer()
                    Button(action: {self.incrementPracticeItemIndex()}) {
                        Image(systemName: "forward.fill").font(.system(size: 40, weight: .heavy))
                    }.padding()
                }.padding()
                
            }.onAppear(perform: {
                self.seconds = (self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60)
                print("Appear")
                })
        .navigationBarItems(trailing: Text("HEYO"))
    }
}

struct PlayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        PlayRoutineView()
    }
}
