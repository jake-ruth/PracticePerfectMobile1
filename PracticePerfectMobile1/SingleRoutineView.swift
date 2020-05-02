//
//  SingleRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 5/1/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI

struct SingleRoutineView: View {
    var routine:PracticeRoutine
    
        @State var addPracticeItem = false
        @State var index = 0
        @State var editMode: EditMode = .inactive
        
        func moveItem(indexSet: IndexSet, destination: Int) {
            let source = indexSet.first!
            
            if source < destination {
                var startIndex = source + 1
                let endIndex = destination - 1
                var startOrder = routine.practiceItems![source].index
                while startIndex <= endIndex {
                    routine.practiceItems![startIndex].index = startOrder
                    startOrder! += 1
                    startIndex = startIndex + 1
                }
                
                routine.practiceItems![source].index = startOrder
                
            } else if destination < source {
                var startIndex = destination
                let endIndex = source - 1
                var startOrder = routine.practiceItems![destination].index! + 1
                let newOrder = routine.practiceItems![destination].index
                while startIndex <= endIndex {
                    routine.practiceItems![startIndex].index = startOrder
                    startOrder += 1
                    startIndex = startIndex + 1
                }
                routine.practiceItems![source].index = newOrder
            }
            
            saveItems()
        }
        
        func saveItems() {
            print("SAVE LOGIC")
        }
        
        var body: some View {
            ZStack {
                VStack {
                    List {
                        ForEach(self.routine.practiceItems ?? []) { practiceItem in
                            VStack (alignment: .leading) {
                                Text("\(practiceItem.title!) - \(practiceItem.minutes) min").font(.system(size: 20, weight: .bold))
                                Text(practiceItem.details!).font(.callout).foregroundColor(Color.gray)
                            }
                        }.onDelete{indexSet in
                            let deleteItem = self.routine.practiceItems![indexSet.first!]
                            
                            print("DELETE")
                        }
                        .onMove(perform: moveItem)
                        
                    }
                    .navigationBarItems(trailing: EditButton() )
                    .sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem) })
                    
                    if (editMode == .inactive){
                        NavigationLink(destination: PlayRoutineView()){
                            HStack {
                            Image(systemName: "play.fill")
                            Text("START ROUTINE")
                            }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 40)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                            .background(self.routine.practiceItems!.count == 0 ? Color.gray : Color.primary)
                                .cornerRadius(5)
                                .padding()
                        }.disabled(self.routine.practiceItems!.count == 0 ? true : false)
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
                        }
                    }
                }.environment(\.editMode, self.$editMode)
            }
        }
}

//struct SingleRoutineView_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleRoutineView()
//    }
//}
