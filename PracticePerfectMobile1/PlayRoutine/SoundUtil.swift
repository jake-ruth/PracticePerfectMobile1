//
//  SoundUtil.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/23/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import AVFoundation

public class SoundUtil {
    var audioPlayer: AVAudioPlayer?
    
    public func playFinishSound(){
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
}
