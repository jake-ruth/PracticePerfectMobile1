//
//  QuickRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Combine

class PracticeItems: ObservableObject {
    var objectWillChange = ObservableObjectPublisher()
    // Every time something changes in the row models array, calls willSet
    var rowModels = [CustomRowModel]() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    func addNewRow(model: CustomRowModel){
        let practiceItemRow = CustomRowModel(id: model.title, title: model.title, details: model.details, minutes: model.minutes, isExpanded: false)
        self.rowModels.append(practiceItemRow)
    }
    
    func removeRow(uuid: String){
        guard let index = self.rowModels.firstIndex(where: {$0.id == uuid}) else {return}
        self.rowModels.remove(at: index)
    }
}

struct QuickRoutineView: View {
    @ObservedObject var practiceItems = PracticeItems()
    @State var addPracticeItem = false
    @State var index = 0
    
    var body: some View {
        VStack {
            List(practiceItems.rowModels) { model in
                CustomRow(model: model, practiceItems: self.practiceItems)
            }.navigationBarItems(trailing:
                Button(action: {
                    self.addPracticeItem.toggle()
                }){
                    Image(systemName: "plus.circle").foregroundColor(Color.primary).font(.system(size: 22, weight: .heavy)).padding(5)
            }).sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem, practiceItems: self.practiceItems ) })
            NavigationLink(destination: PlayRoutineView(practiceItems: practiceItems)){
                Text("START ROUTINE")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(practiceItems.rowModels.count == 0 ? Color.gray : Color.primary)
                    .cornerRadius(5)
                    .padding()
            }.disabled(practiceItems.rowModels.count == 0 ? true : false)
            
        }
    }
    
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
