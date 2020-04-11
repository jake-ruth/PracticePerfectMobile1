//
//  QuickRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Combine

class ListDataSource: ObservableObject {
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    // Every time something changes in the row models array, calls willSet
    var rowModels = [CustomRowModel]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        addNewModel(withName: "TestItem1", details: "this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!this is my test item here!", minutes: 1)
        addNewModel(withName: "TestItem2", details: "this is my test item here 2!", minutes: 2)
    }
    
    private func addNewModel(withName title: String, details: String, minutes: Int){
        let model = CustomRowModel(id: title, title: title, details: details, minutes: minutes, isExpanded: false)
        rowModels.append(model)
    }
}

struct QuickRoutineView: View {
    
    // Binds to something in a different class
    @ObservedObject var dataSource = ListDataSource() // Gets initialized, then automatically makes our models
    @State var addPracticeItem = false
    
    var body: some View {
        List(dataSource.rowModels) { model in
            CustomRow(model: model)
        }.navigationBarItems(trailing:
            Button(action: {
                self.addPracticeItem.toggle()
            }){
                Image(systemName: "plus.circle").foregroundColor(Color.primary).font(.system(size: 22, weight: .heavy)).padding(5)
        }).sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem) })
    }
}

struct CustomRow: View {
    @State var model: CustomRowModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { self.model.isExpanded.toggle() }){
                Text(model.title)
                    .font(.system(size: 20, weight: .bold))
            }
            
            if (model.isExpanded) {
                Text(model.details)
                    .lineLimit(nil)
            } else {
                EmptyView()
            }
        }
    }
}

struct CustomRowModel: Identifiable {
    var id = UUID().uuidString
    var title: String
    var details: String
    var minutes: Int
    var isExpanded: Bool
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
