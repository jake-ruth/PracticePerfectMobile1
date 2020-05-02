//
//  SingleRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SingleRoutineView: View {
        @State var practiceRoutine:PracticeRoutine
        @State var addPracticeItem = false
        @State var index = 0
        @State var editMode: EditMode = .inactive
        @State var practiceItems:Array<NewPracticeItem> = []
        
        func moveItem(indexSet: IndexSet, destination: Int) {
            let source = indexSet.first!
            
            if source < destination {
                var startIndex = source + 1
                let endIndex = destination - 1
                var startOrder = practiceRoutine.practiceItems![source].index
                while startIndex <= endIndex {
                    practiceRoutine.practiceItems![startIndex].index = startOrder
                    startOrder! += 1
                    startIndex = startIndex + 1
                }
                
                practiceRoutine.practiceItems![source].index = startOrder
                
            } else if destination < source {
                var startIndex = destination
                let endIndex = source - 1
                var startOrder = practiceRoutine.practiceItems![destination].index! + 1
                let newOrder = practiceRoutine.practiceItems![destination].index
                while startIndex <= endIndex {
                    practiceRoutine.practiceItems![startIndex].index = startOrder
                    startOrder += 1
                    startIndex = startIndex + 1
                }
                practiceRoutine.practiceItems![source].index = newOrder
            }
        }
        
        func saveItems() {
            //Set new practice items after adding or deleting
            self.practiceRoutine.practiceItems = self.practiceItems
            
            FirebaseController.updateRoutine(practiceRoutine: practiceRoutine)
        }
        
        var body: some View {
            ZStack {
                VStack {
                    List {
                        ForEach(self.practiceItems) { practiceItem in
                            VStack (alignment: .leading) {
                                Text("\(practiceItem.title!) - \(practiceItem.minutes) min").font(.system(size: 20, weight: .bold))
                                Text(practiceItem.details!).font(.callout).foregroundColor(Color.gray)
                            }
                        }.onDelete{indexSet in
                            let deleteItem = self.practiceItems[indexSet.first!]
                            self.practiceItems.remove(at: deleteItem.index!)
                            
                        }
                        .onMove(perform: moveItem)
                        
                    }
                    .navigationBarItems(trailing: EditButton() )
                    .sheet(isPresented: $addPracticeItem, content: { AddItemSheet(show: self.$addPracticeItem, practiceItems: self.$practiceItems) })
                    
                    if (editMode == .inactive){
                        NavigationLink(destination: PlaySingleRoutineView(practiceRoutine: practiceRoutine)){
                            HStack {
                            Image(systemName: "play.fill")
                            Text("START ROUTINE")
                            }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                            .background(self.practiceRoutine.practiceItems!.count == 0 ? Color.gray : Color.primary)
                                .cornerRadius(5)
                                .padding()
                        }.disabled(self.practiceRoutine.practiceItems!.count == 0 ? true : false)
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
                            .padding()
                        }.onDisappear(perform: {
                            self.saveItems()
                        })
                    }
                }.environment(\.editMode, self.$editMode)
            }.navigationBarTitle(Text("").foregroundColor(Color.white),  displayMode: .inline)
                .onAppear(perform: {
                    self.practiceItems = self.practiceRoutine.practiceItems ?? []
                })
    }
}

//struct SingleRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleRoutineView()
//    }
//}
