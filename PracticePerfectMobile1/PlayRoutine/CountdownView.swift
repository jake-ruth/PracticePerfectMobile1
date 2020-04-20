//
//  CountdownView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/18/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct CountdownView: View {
    @Binding var seconds: Int
    
    func formatMinutes() -> String {
        let minutes = self.seconds / 60 % 60
        //Always return double digit
        if minutes < 10 {
            let returnMins = (String(format: "%02d", minutes))
        return returnMins
        } else {
            return String(minutes)
        }
    }
    
    func formatSeconds() -> String {
        let secs = self.seconds % 60
        //Always return double digit
        if secs < 10 {
            let returnSecs = (String(format: "%02d", secs))
        return returnSecs
        } else {
            return String(secs)
        }
    }
    
    var body: some View {
        HStack {
            VStack{
                Text("\(self.formatMinutes())").padding(10).font(.system(size: 70, weight: .semibold, design: .monospaced))
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.clear), lineWidth: 2).background(Color.primary))
                    .foregroundColor(Color(.white))
                    .cornerRadius(5)
                Text("minutes")
            }
            
            VStack{
                Text("\(formatSeconds())").padding(10).font(.system(size: 70, weight: .semibold, design: .monospaced))
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.clear), lineWidth: 2).background(Color.primary))
                    .foregroundColor(Color(.white))
                    .cornerRadius(5)
                Text("seconds")
            }
        }
    }
}

//struct CountdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountdownView(seconds: 0)
//    }
//}
