//
//  PracticeRoutine.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/25/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation

public class PracticeRoutine: Identifiable {
    public var uuid:UUID?
    public var firebaseKey:String?
    public var routineTitle: String?
    public var practiceItems: Array<NewPracticeItem>?
    public var isFavorite: Bool?
    
    //For Firebase
    public func toDictionary() -> NSDictionary {
        var nsPracticeItems: Array<NSDictionary> = []
        
        //Convert practice items to dictionary
        for practiceItem in practiceItems! {
            print(practiceItem)
            nsPracticeItems.append(practiceItem.toDictionary())
        }
        
        return ["uuid": uuid?.uuidString,
                "routineTitle": routineTitle!,
                "practiceItems": nsPracticeItems,
                "isFavorite" : isFavorite!]
    }
}
