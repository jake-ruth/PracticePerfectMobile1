//
//  PlayRoutineViewTwo.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/18/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import UserNotifications
import UIKit
import AVFoundation

struct PlayRoutineView: View {
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var practiceItemIndex: Int = 0
    @State var seconds: Int = 0
    @State var playing: Bool = true
    @State var showAlert: Bool = false
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var showMetronome: Bool = false
    @State var audioPlayer: AVAudioPlayer?
    
    init() {
        //Keep awake
        UIApplication.shared.isIdleTimerDisabled = true
        NotificationUtil.requestAccess()
    }
    
    //Want to extract this
    func playFinishSound(){
        let path = Bundle.main.path(forResource: "completed1", ofType: "wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            print("Playing")
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.play()
        } catch {
            print("couldn't play")
        }
    }
    
    func incrementPracticeItemIndex() {
        //First cancel all notifications
        NotificationUtil.cancelAllNotifications()
        
        let soundUtil = SoundUtil()
        soundUtil.playFinishSound(audioPlayer: audioPlayer)
        if (self.practiceItemIndex < self.practiceItemsStored.count - 1) {
            self.practiceItemIndex += 1
            self.seconds = self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60
            NotificationUtil.scheduleNotification(seconds: self.seconds)
        } else {
            self.showAlert = true
        }
    }
    
    func decrementPracticeItemIndex() {
        //First cancel all notifications
        NotificationUtil.cancelAllNotifications()
        
        if (self.practiceItemIndex > 0) {
            self.practiceItemIndex -= 1
            self.seconds = self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60
            NotificationUtil.scheduleNotification(seconds: self.seconds)
        }
    }
    
    func handlePlaying() {
        self.playing.toggle()

        if (self.playing == false){
            NotificationUtil.cancelAllNotifications()
        } else if (self.playing == true){
            NotificationUtil.scheduleNotification(seconds: self.seconds)
        }
    }
    
    var body: some View {
        ZStack {
            Color.surface.edgesIgnoringSafeArea(.all)
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
                        self.incrementPracticeItemIndex()
                        self.playFinishSound()
                    }
                }
                Spacer()
                HStack {
                    Button(action: {self.decrementPracticeItemIndex()}) {
                        Image(systemName: "backward.fill").font(.system(size: 40, weight: .heavy))
                    }.padding()
                    Spacer()
                    Button(action: { self.handlePlaying()}) {
                        Image(systemName: self.playing ? "pause.circle" : "play.circle").font(.system(size: 60, weight: .heavy))
                    }.padding().animation(
                        Animation.easeInOut(duration: 2).delay(1)
                    )
                    Spacer()
                    Button(action: {self.incrementPracticeItemIndex()}) {
                        Image(systemName: "forward.fill").font(.system(size: 40, weight: .heavy))
                    }.padding()
                }.padding()
                
            }.onAppear(perform: {
                self.seconds = (self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60)
                self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                NotificationUtil.scheduleNotification(seconds: self.practiceItemsStored[self.practiceItemIndex].minutes as! Int * 60)
            })
                .onDisappear(perform: {
                    self.practiceItemIndex = 0
                })
                .alert(isPresented: self.$showAlert) {
                    Alert(title: Text("Routine Complete!"),
                          dismissButton: .default (Text("OK")) {
                            self.showAlert = false
                            self.presentationMode.wrappedValue.dismiss()
                        })
            }
            .navigationBarItems(trailing: Button(action: {self.showMetronome = true}) {
                Image("MetronomeIcon")
                    .resizable()
                    .frame(width: 45, height: 45)
            })
                .sheet(isPresented: $showMetronome, content: { MetronomeView()})
        }
    }
}

struct PlayRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        PlayRoutineView()
    }
}
