//
//  AddItemModal.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/11/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Combine

struct AddItemModal: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @Binding var showModal: Bool
    @State var title: String = "initial"
    @State var details: String = "Enter details..."
    @State var minutes: Int = 1
    var minuteOptions = Array(1...60);
    
    func createNewItem(){
        let practiceItem = PracticeItem(context: self.moc)
        practiceItem.uuid = UUID()
        practiceItem.title = self.title
        practiceItem.details = self.details
        practiceItem.minutes = self.minutes + 1 as NSNumber
        practiceItem.index = NSNumber(value: self.practiceItemsStored.count)
        do {
            try self.moc.save()
        } catch {
            print("ERR: ", error)
        }
        self.showModal = false
    }
    
    
    
    var body: some View {
        VStack {
            Section(header: Text("Add Practice Item").font(.system(size: 30, weight: .semibold))) {
                CustomTextField(
                    placeholder: Text("Title").foregroundColor(.gray).font(.system(size: 20)),
                    text: $title
                ).onAppear(perform: {self.title = ""}).padding(.vertical, 30).padding(.horizontal, 10)
                
                MultilineTextView(text: $details).padding(.horizontal, 10)
                
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
                    
                    Button(action: {self.createNewItem()}){
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
        }.modifier(DismissingKeyboard())
    }
}


//For Canvas
struct AddItemModal_Previews: PreviewProvider {
    static var previews: some View {
        AddItemModal(showModal: .constant(true))
    }
}
