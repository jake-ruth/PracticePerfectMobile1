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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    
    var objectWillChange = ObservableObjectPublisher()
    // Every time something changes in the row models array, calls willSet
    var rowModels = [CustomRowModel]() {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    
    func addNewPracticeItem(practiceItem: PracticeItemModel){
        let practiceItemRow = CustomRowModel(practiceItem: practiceItem, isExpanded: false)
        self.rowModels.append(practiceItemRow)
        let practiceItem1 = PracticeItem(context: self.managedObjectContext)
        practiceItem1.uuid = UUID()
        practiceItem1.title = "ET"
        practiceItem1.details = "Deets"
        practiceItem1.minutes = NSNumber(value: practiceItem.minutes!) 
        do {
            try self.managedObjectContext.save()
        } catch {
            print("ITEM: ", practiceItem1)
            print("ERR: ", error)
        }
    }
    
    func removeRow(uuid: String){
        guard let index = self.rowModels.firstIndex(where: {$0.id == uuid}) else {return}
        self.rowModels.remove(at: index)
    }
}

struct QuickRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    @ObservedObject var practiceItems = PracticeItems()
    @State var newPracticeItem = PracticeItemModel()
    @State var addPracticeItem = false
    @State var index = 0
    
    public func addNewPracticeItem(){
        let practiceItem1 = PracticeItem(context: self.managedObjectContext)
        practiceItem1.uuid = UUID()
        practiceItem1.title = newPracticeItem.title
        practiceItem1.details = newPracticeItem.details
        practiceItem1.minutes = newPracticeItem.minutes as NSNumber?
        do {
            try self.managedObjectContext.save()
        } catch {
            print("ITEM: ", practiceItem1)
            print("ERR: ", error)
        }
    }
    
    var body: some View {
        VStack {
            List(self.practiceItemsStored) { practiceItem in
                VStack {
                Text(practiceItem.title!)
                Text(practiceItem.details!)
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.addPracticeItem.toggle()
                }){
                    Image(systemName: "plus.circle").foregroundColor(Color.primary).font(.system(size: 22, weight: .heavy)).padding(5)
            }).sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem, newPracticeItem: self.$newPracticeItem, practiceItems: self.practiceItems ) })
            
            
//            Section(header: Text("To Do's")) {
//                ForEach(self.practiceItemsStored) {todoItem in
//                    Text(todoItem.title!)
//                }.onDelete{indexSet in
//                    let deleteItem = self.practiceItemsStored[indexSet.first!]
//                    self.managedObjectContext.delete(deleteItem)
//
//                    do {
//                        try self.managedObjectContext.save()
//                    } catch {
//                        print(error)
//                    }
//                }
//            }
            
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
            
            Button("ADD to store", action: {self.addNewPracticeItem()})
            
            
        }.onAppear(perform: {print("PRACTICE LIST:", self.practiceItemsStored)})
    }
    
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
