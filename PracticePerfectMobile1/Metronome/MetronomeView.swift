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
    @State private var subdivision: Int = 1
    private var options = [ 1, 2, 3 , 4]
    private var metronome = AKMetronome()
    
    func playMetronome(bpm: Int, subdivision: Int) {
        self.metronome.tempo = Double(bpm);
        self.metronome.subdivision = subdivision;
        AudioKit.output = self.metronome
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

    var body: some View {
        VStack {
            Text(String(Int(self.bpm)))
            Slider(value: $bpm, in: 40.0...320, step: 1).padding()
            Picker(selection: $subdivision, label: Text("")) {
                ForEach(0 ..< self.options.count) { index in
                    Text(String(index) + "/4")
                }
            }.labelsHidden()
            Button(action:
            { self.handleMetronome() }){
                Text(isPlaying == true ? "Stop" : "Start")
                .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(isPlaying == true ? Color.secondary : Color.primary)
                    .cornerRadius(5)
                    .padding()
            }
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
