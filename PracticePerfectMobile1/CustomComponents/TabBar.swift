//
//  TabBar.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/26/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct TabBar : View {
    @Binding var index: Int
    
    var body : some View {
        ZStack {
            Color.card2.edgesIgnoringSafeArea(.bottom)
        HStack (spacing: 15) {
            HStack {
                Image(systemName: "house.fill").resizable().frame(width: 30, height: 25)
                Text(self.index == 0 ? "Home" : "").fontWeight(.light).font(.system(size: 11))
            }.padding(15)
                .background(self.index == 0 ? Color.primary : Color.clear)
                .clipShape(Capsule())
                .onTapGesture {
                    self.index = 0
            }
            
            HStack {
                Image(systemName: "music.note.list").resizable().frame(width: 25, height: 25)
                Text(self.index == 1 ? "Routines" : "").fontWeight(.light).font(.system(size: 11))
                
            }.padding(15)
                .background(self.index == 1 ? Color.primary : Color.clear)
                .clipShape(Capsule())
                .onTapGesture {
                    self.index = 1
            }
            
            HStack {
                Image(systemName: "metronome").resizable().frame(width: 25, height: 25)
                Text(self.index == 2 ? "Tools" : "").fontWeight(.light).font(.system(size: 11))
                
            }.padding(15)
                .background(self.index == 2 ? Color.primary : Color.clear)
                .clipShape(Capsule())
                .onTapGesture {
                    self.index = 2
            }
            
            HStack {
                Image(systemName: "gear").resizable().frame(width: 25, height: 25)
                Text(self.index == 3 ? "Settings" : "").fontWeight(.light).font(.system(size: 11))
                
            }.padding(15)
                .background(self.index == 3 ? Color.primary : Color.clear)
                .clipShape(Capsule())
                .onTapGesture {
                    self.index = 3
            }
            
        }.padding(.top, 8)
            .padding(.bottom, 8)
            .frame(width: UIScreen.main.bounds.width)
            .background(Color.card2)
            .animation(.default)
        }.frame(idealHeight: 50, maxHeight: 70)
    }
}
