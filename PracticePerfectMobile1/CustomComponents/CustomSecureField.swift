//
//  CustomSecureField.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/11/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct CustomSecureField: View {
    
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.padding(10).font(.system(size: 20))
            }
            SecureField("", text: $text, onCommit: commit)
                .font(.system(size: 20))
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                .foregroundColor(Color(.white))
        }
    }
}

//struct CustomSecureField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSecureField()
//    }
//}
