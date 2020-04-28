//
//  CardView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/25/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    let practiceRoutine: PracticeRoutine
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7, style: .continuous).fill(Color.card2).overlay(RoundedRectangle(cornerRadius: 7)
                .stroke(Color.card, lineWidth: 1))
            VStack {
                HStack{
                    
                    Text(practiceRoutine.routineTitle!)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {print("Favorite Logic")}) {
                        Image(systemName: "star").font(.system(size: 22, weight: .semibold)).foregroundColor(Color.white)
                    }
                }
                Divider()
                
                HStack {
                    
                VStack(alignment: .leading) {
                    ForEach(0..<self.practiceRoutine.practiceItems!.count) {
                        Text("\(self.practiceRoutine.practiceItems![$0].title!) - \(self.practiceRoutine.practiceItems![$0].minutes) min")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                    Image(systemName: "chevron.right")
                    .foregroundColor(Color.white)
                }
            }
            .padding(10)
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .padding(.bottom, 0)
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(practiceRoutine: )
//    }
//}
