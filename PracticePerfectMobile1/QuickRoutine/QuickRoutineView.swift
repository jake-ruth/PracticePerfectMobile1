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
    
    var body: some View {
        VStack {
            List(self.practiceItemsStored) { practiceItem in
                VStack {
                Text(practiceItem.title!)
                Text(practiceItem.minutes!.stringValue)
                Text(practiceItem.details!)
                }
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.addPracticeItem.toggle()
                }){
                    Image(systemName: "plus.circle").foregroundColor(Color.primary).font(.system(size: 22, weight: .heavy)).padding(5)
            }).sheet(isPresented: $addPracticeItem, content: { AddItemModal(showModal: self.$addPracticeItem).environment(\.managedObjectContext, self.managedObjectContext) })
            
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
    }
    
}

struct QuickRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        QuickRoutineView()
    }
}
