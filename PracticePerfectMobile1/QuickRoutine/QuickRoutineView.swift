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
    
    func addNewPracticeItem(practiceItem: PracticeItemModel){
        let practiceItemRow = CustomRowModel(practiceItem: practiceItem, isExpanded: false)
        self.rowModels.append(practiceItemRow)
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
    @State var addPracticeItem = false
    @State var index = 0
    
    func moveItem(indexSet: IndexSet, destination: Int) {
        let source = indexSet.first!
        
        if source < destination {
            var startIndex = source + 1
            let endIndex = destination - 1
            var startOrder = practiceItemsStored[source].index
            while startIndex <= endIndex {
                practiceItemsStored[startIndex].index = startOrder
                startOrder = NSNumber(value: startOrder as! Int + 1)
                startIndex = startIndex + 1
            }
            
            practiceItemsStored[source].index = startOrder
            
        } else if destination < source {
            var startIndex = destination
            let endIndex = source - 1
            var startOrder = NSNumber(value: practiceItemsStored[destination].index as! Int + 1)
            let newOrder = practiceItemsStored[destination].index
            while startIndex <= endIndex {
                practiceItemsStored[startIndex].index = startOrder
                startOrder = NSNumber(value: startOrder as! Int + 1)
                startIndex = startIndex + 1
            }
            practiceItemsStored[source].index = newOrder
        }
        
        saveItems()
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(self.practiceItemsStored) { practiceItem in
                    VStack {
                        Text(practiceItem.title!).font(.headline)
                        Text(practiceItem.details!).font(.caption)
                    }
                }.onDelete{indexSet in
                    let deleteItem = self.practiceItemsStored[indexSet.first!]
                    self.managedObjectContext.delete(deleteItem)
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }
                .onMove(perform: moveItem)
                
            }
            .navigationBarItems(trailing: EditButton())
            .sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem).environment(\.managedObjectContext, self.managedObjectContext) })
            
            NavigationLink(destination: PlayRoutineView()){
                Text("START ROUTINE")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(self.practiceItemsStored.count == 0 ? Color.gray : Color.primary)
                    .cornerRadius(5)
                    .padding()
            }.disabled(self.practiceItemsStored.count == 0 ? true : false)
            Button(action: {self.addPracticeItem.toggle()}){
                Text("Add Practice Item")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(Color.secondary)
                    .cornerRadius(5)
                    .padding(20)
            }
        }
        //        .navigationBarItems(trailing:
        //            Button(action: {
        //                self.addPracticeItem.toggle()
        //                let impactMed = UIImpactFeedbackGenerator(style: .medium)
        //                impactMed.impactOccurred()
        //            }){
        //                Image(systemName: "plus.circle").foregroundColor(Color.primary).font(.system(size: 22, weight: .heavy)).padding(5)
        //        }).sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem).environment(\.managedObjectContext, self.managedObjectContext) })
    }
    
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
