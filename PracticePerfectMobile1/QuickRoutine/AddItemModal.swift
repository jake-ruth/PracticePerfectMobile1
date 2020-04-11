//
//  AddItemModal.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/11/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct AddItemModal: View {
    @Binding var showModal: Bool
    @State var title: String = "initial"
    @State var details: String = "initial"
    @State var minutes: Int = 1
    
    
    var minuteOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    
    var body: some View {
        Section(header: Text("Add Practice Item").font(.system(size: 30, weight: .semibold))) {
            VStack {
                CustomTextField(
                    placeholder: Text("Title").foregroundColor(.gray).font(.system(size: 20)),
                    text: $title
                ).onAppear(perform: {self.title = ""}).padding(.vertical, 30)
                
                CustomTextField(
                    placeholder: Text("Details").foregroundColor(.gray).font(.system(size: 20)),
                    text: $details
                ).onAppear(perform: {self.details = ""})
                
                Picker(selection: $minutes, label: Text("")) {
                    ForEach(0 ..< minuteOptions.count) {
                        Text(String(self.minuteOptions[$0]) + "min")
                    }
                }.labelsHidden()
                
                HStack {
                    Button(action: {self.showModal.toggle()}){
                        Text("Cancel")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                            .background(Color.secondary)
                            .cornerRadius(5)
                            .padding(20)
                    }
                    
                    Button(action: {print("Create new item")}){
                        Text("Add")
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .bold))
                            .background(Color.primary)
                            .cornerRadius(5)
                            .padding(20)
                    }
                    
                    
                }
            }
        }
    }
}

struct AddItemModal_Previews: PreviewProvider {
    static var previews: some View {
        AddItemModal(showModal: .constant(true))
    }
}
