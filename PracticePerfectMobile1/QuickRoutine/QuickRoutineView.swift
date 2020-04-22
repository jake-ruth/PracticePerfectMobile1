//
//  QuickRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/10/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import Combine


struct QuickRoutineView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
    //@ObservedObject var practiceItems = PracticeItems()
    @State var addPracticeItem = false
    @State var index = 0
    @State var editMode: EditMode = .inactive
    
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
        ZStack {
            
            Color.surface.edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    ForEach(self.practiceItemsStored) { practiceItem in
                        VStack {
                            Text("\(practiceItem.title!) - \(practiceItem.minutes!) min").font(.headline)
                            Text(practiceItem.details!).font(.caption)
                        }.listRowBackground(Color.surface)
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
                .navigationBarItems(trailing: Button(action: {print("EDIT")}) {EditButton() })
                .sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem).environment(\.managedObjectContext, self.managedObjectContext) })
                
                if (editMode == .inactive){
                    
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
                }
                
                if (self.editMode == .active){
                    
                    Button(action: {self.addPracticeItem.toggle()}){
                        HStack {
                        Image(systemName: "plus")
                        Text("ADD PRACTICE ITEM")
                        }.frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.secondary)
                        .cornerRadius(5)
                        .padding(20)
                    }
                }
            }.environment(\.editMode, self.$editMode)
        }
    }
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
