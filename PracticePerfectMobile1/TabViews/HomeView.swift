//
//  HomeView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
                ZStack {
                    Text("HOME")
            }.navigationBarTitle(Text("Home").foregroundColor(Color.white), displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
