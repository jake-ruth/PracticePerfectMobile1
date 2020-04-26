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
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.card)
                //.shadow(color: Color.gray, radius: 10)
            
            VStack {
                HStack{
                    
                    Text(practiceRoutine.routineTitle!)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {print("Favorite Logic")}) {
                        Image(systemName: "star").font(.system(size: 20, weight: .medium)).foregroundColor(Color.white)
                    }
                }
                
                List {
                    
                    ForEach(0..<self.practiceRoutine.practiceItems!.count) {
                        
                        Text(self.practiceRoutine.practiceItems![$0])
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                    }
                }.environment(\.defaultMinListRowHeight, 10)
                HStack {
                    Button(action: {print("Select")}){
                        Text("SELECT").foregroundColor(Color.primary).font(.system(size: 18))
                    }
                    Spacer()
                    Button(action: {print("Delete")}){
                        Text("DELETE").foregroundColor(Color.secondary).font(.system(size: 18))
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(height: 250)
        .padding()
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(practiceRoutine: )
//    }
//}
