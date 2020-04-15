//
//  RoutineTimerView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/14/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct RoutineTimerView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var seconds: Int = 60
    
    var body: some View {
        Text("\(seconds) seconds left").onReceive(timer) { input in
            self.seconds -= 1
        }
    }
}

struct RoutineTimerView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineTimerView()
    }
}
