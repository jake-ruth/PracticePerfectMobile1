//
//  MyRoutinesView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct MyRoutinesView: View {
    
    @State var pressed = false
    
    func testFunction() -> Void {
        print("TESTING")
    }
    
    var body: some View {
        ZStack {
            Color.surface.edgesIgnoringSafeArea(.all)
            Text("Favorite Routines").foregroundColor(Color.white)
            
            Rectangle()
                .frame(height: 250)
                .cornerRadius(10)
                .foregroundColor(Color.card)
                .padding(20)
            
            Button(action: {self.testFunction()}) {
                Text("Test!")
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
            }
        }.onAppear{ print("fetch routine from store")}
    }
}

struct MyRoutinesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRoutinesView()
    }
}

