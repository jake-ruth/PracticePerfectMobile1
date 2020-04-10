//
//  SettingsView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/9/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Color.surface.edgesIgnoringSafeArea(.all)
                List{
                    Text("aaah").foregroundColor(.white)
                    Text("ah2").foregroundColor(.white)
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

