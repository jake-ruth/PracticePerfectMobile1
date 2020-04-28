//
//  CreateRoutineView.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/27/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import Firebase

struct CreateRoutineView: View {
    @State var practiceItems: Array<NewPracticeItem> = []
    @State var addPracticeItem: Bool = false
    @State var routineTitle: String = "initial"
    @State var isFavorite: Bool = false
    var ref: DatabaseReference! = Database.database().reference()
    var uid = Auth.auth().currentUser?.uid
    
    func saveRoutine(){
        print("saving routine")
        //Save routine logic
        let practiceRoutine = PracticeRoutine()
        practiceRoutine.uuid = UUID()
        practiceRoutine.routineTitle = self.routineTitle
        practiceRoutine.practiceItems = self.practiceItems
        practiceRoutine.isFavorite = self.isFavorite
        
        //Needs to be of certain types for firebase! Doesn't work yet
        self.ref.child("practiceRoutines").child(uid ?? "").setValue(["practiceRoutine" : practiceRoutine])
        
    }
    
    func addItem(){
        let practiceItem1 = NewPracticeItem()
        practiceItem1.uuid = UUID()
        practiceItem1.title = "Practice Scales"
        practiceItem1.details = "Practice in Every key"
        practiceItem1.minutes = 20
        self.practiceItems.append(practiceItem1);
    }
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    CustomTextField(
                        placeholder: Text("Routine Title").foregroundColor(.gray).font(.system(size: 20)),
                        text: $routineTitle
                    ).onAppear(perform: {self.routineTitle = ""}).padding(.vertical, 30).padding(.horizontal, 10)
                    List {
                        ForEach(self.practiceItems) { practiceItem in
                            VStack (alignment: .leading) {
                                Text("\(practiceItem.title!) - \(practiceItem.minutes) min").font(.system(size: 20, weight: .bold))
                                Text(practiceItem.details!).font(.callout).foregroundColor(Color.gray)
                            }.listRowBackground(Color.surface)
                        }.onDelete{indexSet in
                            let deleteItem = self.practiceItems[indexSet.first!]
                            self.practiceItems.remove(at: deleteItem.index ?? 0)
                            
                        }
                        //.onMove(perform: moveItem)
                    }
                    HStack {
                        
                        Button(action: { self.addPracticeItem.toggle() }){
                            Text("Add Practice Item")
                        }
                        Spacer()
                        Button(action: { self.saveRoutine() }){
                            Text("Save Routine")
                        }
                    }
                }
            }
        }.navigationBarTitle(Text("Create Routine").foregroundColor(Color.white), displayMode: .inline)
            .sheet(isPresented: $addPracticeItem, content: { AddItemSheet(show: self.$addPracticeItem, practiceItems: self.$practiceItems) })
    }
}

struct CreateRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutineView()
    }
}
