//
//  NavbarSettings.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 5/8/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import Combine

//Our global application state for firebase data
class NavbarSettings: ObservableObject {
    @Published var navbarVisible: Bool = true
    
    func setNavbarVisible() -> Void {
        self.navbarVisible.toggle()
    }
}
