//
//  FirebaseController.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/29/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import Combine

//Our global application state for firebase data
class FirebaseController: ObservableObject {
    @Published var practiceRoutines: [PracticeRoutine] = []
    
    init(){
        if (Auth.auth().currentUser != nil){
            fetchAllRoutines()
        }
    }
    
    //Get all practice routines of a user
    func fetchAllRoutines() -> Void {
            FirebaseConstants.practiceRoutinesRef.observe(.value) {
                snapshot in
                self.practiceRoutines.removeAll()
                for child in snapshot.children {
                    let snap = child as! DataSnapshot
                    let value = snap.value as? [String: Any]
                    let key = snap.key
                    
                    //Build up Practice Routine
                    let practiceRoutine = PracticeRoutine()
                    practiceRoutine.uuid = value?["uuid"] as? UUID
                    practiceRoutine.routineTitle = value?["routineTitle"] as? String
                    practiceRoutine.isFavorite = value?["isFavorite"] as? Bool
                    practiceRoutine.firebaseKey = key
                    
                    //items is an array of dictionaries
                    let items = value?["practiceItems"] as! Array<[String: Any]>
                    
                    var practiceItems:[NewPracticeItem] = []
                    
                    //Build up practice items for routine
                    for item in items {
                        let practiceItem = NewPracticeItem()
                        practiceItem.index = item["index"] as? Int
                        practiceItem.title = item["title"] as? String
                        practiceItem.details = item["details"] as? String
                        practiceItem.minutes = item["minutes"] as? Int ?? 0
                        practiceItems.append(practiceItem)
                    }
                    
                    practiceRoutine.practiceItems = practiceItems
                    
                    self.practiceRoutines.append(practiceRoutine)
                }
            }
    }
    
    //Update a practice routine by firebase key
    static func updateRoutine(practiceRoutine: PracticeRoutine) -> Void {
        let singleRoutineRef = FirebaseConstants.getSingleRoutineRef(key: practiceRoutine.firebaseKey ?? "")
        singleRoutineRef.updateChildValues(practiceRoutine.toDictionary() as! [AnyHashable : Any])
    }
    
    //Delete a practice routine
    static func deleteRoutine(practiceRoutine: PracticeRoutine) -> Void {
        //self.practiceRoutines = self.practiceRoutines.filter { $0.firebaseKey != practiceRoutine.firebaseKey }
        let singleRoutineRef = FirebaseConstants.getSingleRoutineRef(key: practiceRoutine.firebaseKey ?? "")
        singleRoutineRef.removeValue(completionBlock: {(error, ref) in
            if error != nil {
                print("error \(String(describing: error))")
            }
            
        })
    }
}
