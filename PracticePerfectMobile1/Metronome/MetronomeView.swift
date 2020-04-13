//
//  MetronomeView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import AudioKit


struct MetronomeView: View {
    @State private var isPlaying: Bool = false
    @State private var bpm: Double = 100
    @State private var subdivision: Int = 4
    @State  private var beats = [true, true, true, true]
    private var subdivisionOptions: Array<Int> = [4, 3, 5, 7, 9]
    var metronome = AKMetronome()
    var mixer : AKMixer;
    
    init() {
        self.mixer = AKMixer(metronome);
        //.mixer.volume = 0.0;
        AudioKit.output = self.mixer;
        self.metronome.callback = {
            [self] in
            if(self.metronome.currentBeat == 1)
            {
                print("here")
                
                let node = self.mixer.avAudioNode as? AVAudioMixerNode;
                if(node != nil)
                {
                    print("here");
                    node?.outputVolume = 0.0;
                }
            }
            else
            {
                print("in here")
                let node = self.mixer.avAudioNode as? AVAudioMixerNode;
                if(node != nil)
                {
                    print("here");
                    node?.outputVolume = 0.9;
                }

                //self.mixer.volume = 0.9;
            }
            print(self.metronome.currentBeat)
        }
    }

    
    func playMetronome(bpm: Int, subdivision: Int) {
    
        self.metronome.tempo = Double(bpm);
        self.metronome.subdivision = subdivision;
        
        AudioKit.output = self.mixer;
        do {
            try AudioKit.start()
            self.isPlaying = true
        }
        catch{
            print("ERROR")
        }
        
        self.metronome.start()
        
    }
    
    func stopMetronome() {
        self.isPlaying = false
        self.metronome.stop()
        do {
            try AudioKit.stop()
        } catch {
            print("ERROR stopping");
        }
        
        
    }
    
    func handleMetronome() {
        self.isPlaying.toggle()
        if (self.isPlaying == true){
            self.playMetronome(bpm: Int(self.bpm), subdivision: self.subdivision)
        } else if (self.isPlaying == false){
            self.stopMetronome()
        }
    }
    
    func setBeat(index: Int){
        self.beats[index].toggle()
    }
    
    var body: some View {
        VStack {
            Text(String(Int(self.bpm)))
            Slider(value: $bpm, in: 40.0...320, step: 1).padding()
            Picker(selection: $subdivision, label: Text("")) {
                ForEach(0 ..< subdivisionOptions.count) {
                    Text(String(self.subdivisionOptions[$0]) + "/4")
                }
            }.labelsHidden()
            Button(action:
            { self.handleMetronome() }){
                Text(isPlaying == true ? "Stop" : "Start")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(isPlaying == true ? Color.secondary : Color.primary)
                    .cornerRadius(5)
            }
            
//            HStack {
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//            }
        }
    }
}

class ARMetronome {
    public var bpm: Int = 100
    public var subdivision: Int = 4
    private var player: AVAudioPlayer
    private var timer: Timer
    
    func playTick(timer: Timer) -> Void
    {
        self.player.play(atTime: 0.1);
    }
    
    init(){
        self.player = AVAudioPlayer()
        self.timer = Timer()
        do{
            print("here")
            let path = Bundle.main.path(forResource: "mainTick.wav", ofType: nil)!
            self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            self.player.prepareToPlay()
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(0.1),
                                              repeats: true,
                                              block: self.playTick)
            
        }
        catch{
            print("Error!")
        }
    }
}

//struct MetronomeView: View {
//    @State private var isPlaying: Bool = false
//    @State private var bpm: Double = 100
//    @State private var subdivision: Int = 4
//    @State  private var beats = [true, true, true, true]
//    private var subdivisionOptions: Array<Int> = [4, 3, 5, 7, 9]
//    private var metronome = ARMetronome()
//
//    init() {
//    }
//
//
//    func playMetronome(bpm: Int, subdivision: Int) {
//
//    }
//
//    func stopMetronome() {
//
//    }
//
//    func handleMetronome() {
//        self.isPlaying.toggle()
//        if (self.isPlaying == true){
//            self.playMetronome(bpm: Int(self.bpm), subdivision: self.subdivision)
//        } else if (self.isPlaying == false){
//            self.stopMetronome()
//        }
//    }
//
//    func setBeat(index: Int){
//        self.beats[index].toggle()
//    }
//
//    var body: some View {
//        VStack {
//            Text(String(Int(self.bpm)))
//            Slider(value: $bpm, in: 40.0...320, step: 1).padding()
//            Picker(selection: $subdivision, label: Text("")) {
//                ForEach(0 ..< subdivisionOptions.count) {
//                    Text(String(self.subdivisionOptions[$0]) + "/4")
//                }
//            }.labelsHidden()
//            Button(action:
//            { self.handleMetronome() }){
//                Text(isPlaying == true ? "Stop" : "Start")
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .frame(height: 40)
//                    .foregroundColor(.white)
//                    .font(.system(size: 14, weight: .bold))
//                    .background(isPlaying == true ? Color.secondary : Color.primary)
//                    .cornerRadius(5)
//            }
//
//            // Experiment
//            HStack {
////                Button(action: setBeat(index: 0)) {
////                    Text("asdf")
////                        .frame(minWidth: 0, maxWidth: .infinity)
////                        .frame(height: 40)
////                        .foregroundColor(.white)
////                        .font(.system(size: 14, weight: .bold))
////                        .background(Color.primary)
////                        .cornerRadius(5)
////                }
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//                Rectangle().padding().foregroundColor(Color.primary)
//            }
//        }
//    }
//}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
