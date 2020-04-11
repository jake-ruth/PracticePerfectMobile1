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
    @State private var bpm: Int = 100
    @State private var subdivision: Int = 4
    
    var metronome = AKMetronome()
    
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
      print("In play metronome");
        self.isPlaying = false
      self.metronome.stop()
      do {
        try AudioKit.stop()
      } catch {
        print("ERROR stopping");
      }
      
      
    }
    
    var body: some View {
        VStack {
            
        Text("Metronome")
            Button(action:
            { self.playMetronome(bpm: 200, subdivision: 4) }){
                Text(isPlaying == true ? "Stop" : "Start")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.primary)
                    .cornerRadius(5)
            }
        }
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
    }
}
