////
////  PracticeItems.swift
////  PracticePerfectMobile1
////
////  Created by Admin on 4/16/20.
////  Copyright © 2020 JakeRuthMusic. All rights reserved.
////
//
//import Foundation
//import CoreData
//import Combine
//
//public class PracticeItems: ObservableObject {
//    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(fetchRequest: PracticeItem.getAllPracticeItems()) var practiceItemsStored:FetchedResults<PracticeItem>
//    
//    public var objectWillChange = ObservableObjectPublisher()
//    // Every time something changes in the row models array, calls willSet
//    var rowModels = [CustomRowModel]() {
//        willSet {
//            self.objectWillChange.send()
//        }
//    }
//    
//    
//    func addNewPracticeItem(practiceItem: PracticeItemModel){
//        let practiceItemRow = CustomRowModel(practiceItem: practiceItem, isExpanded: false)
//        self.rowModels.append(practiceItemRow)
//        let practiceItem1 = PracticeItem(context: self.managedObjectContext)
//        practiceItem1.uuid = UUID()
//        practiceItem1.title = "ET"
//        practiceItem1.details = "Deets"
//        practiceItem1.minutes = NSNumber(value: practiceItem.minutes!)
//        do {
//            try self.managedObjectContext.save()
//        } catch {
//            print("ITEM: ", practiceItem1)
//            print("ERR: ", error)
//        }
//    }
//    
//    func removeRow(uuid: String){
//        guard let index = self.rowModels.firstIndex(where: {$0.id == uuid}) else {return}
//        self.rowModels.remove(at: index)
//    }
//}
