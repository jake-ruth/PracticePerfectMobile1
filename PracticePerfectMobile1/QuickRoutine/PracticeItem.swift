//
//  PracticeItem.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/16/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import CoreData

//Identifiable so eached managed object is identifiable
public class PracticeItem:NSManagedObject, Identifiable {
    @NSManaged public var uuid:UUID?
    @NSManaged public var title:String?
    @NSManaged public var details:String?
    @NSManaged public var minutes:NSNumber?
}

extension PracticeItem {
    static func getAllPracticeItems() -> NSFetchRequest<PracticeItem> {
        let request:NSFetchRequest<PracticeItem> = PracticeItem.fetchRequest() as!
            NSFetchRequest<PracticeItem>
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
