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
    
    func saveRoutine(){
        print("saving routine")
        //Save routine logic
        let practiceRoutine = PracticeRoutine()
        practiceRoutine.uuid = UUID()
        practiceRoutine.routineTitle = self.routineTitle
        practiceRoutine.practiceItems = self.practiceItems
        practiceRoutine.isFavorite = self.isFavorite
        
        let practiceRoutineDictionary = practiceRoutine.toDictionary();
        print(practiceRoutineDictionary)
        
        //Add dictionary to firebase
        FirebaseConstants.practiceRoutinesRef.childByAutoId().setValue(practiceRoutineDictionary)
        
    }
    
    func addItem(){
        let practiceItem = NewPracticeItem()
        practiceItem.title = "Practice Scales"
        practiceItem.details = "Practice in Every key"
        practiceItem.minutes = 20
        self.practiceItems.append(practiceItem);
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
                    Spacer()
                    Button(action: { self.saveRoutine() }){
                        Text("SAVE ROUTINE")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(Color.primary)
                        .cornerRadius(5)
                        .padding(14)
                    }
                }
            }
        }
        .navigationBarItems(
            trailing: Button(action: { self.addPracticeItem.toggle() }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 23, height: 23)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.primary)
        })
            .navigationBarTitle(Text("Create Routine").foregroundColor(Color.white), displayMode: .inline)
            .sheet(isPresented: $addPracticeItem, content: { AddItemSheet(show: self.$addPracticeItem, practiceItems: self.$practiceItems) })
    }
}

struct CreateRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutineView()
    }
}
