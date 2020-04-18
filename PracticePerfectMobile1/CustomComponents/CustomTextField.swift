//
//  CustomTextField.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/11/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder.padding(10).font(.system(size: 20))
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .font(.system(size: 20))
            .padding(12)
                .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color(.gray), lineWidth: 2))
                .foregroundColor(Color(.white))
        }
    }
}

//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField(placeholder: "", text: "")
//    }
//}
