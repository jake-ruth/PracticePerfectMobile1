//
//  FirebaseConstants.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/28/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

public class FirebaseConstants {
    static let rootRef:DatabaseReference! = Database.database().reference()
    
    static let currentUid = Auth.auth().currentUser?.uid
    
    //Fails currently
    static let practiceRoutinesRef = rootRef.child("practiceRoutines").child(currentUid ?? "")
    
    //Get ref for a single practice routine by key
    static func getSingleRoutineRef(key: String) -> DatabaseReference{
        return rootRef.child("practiceRoutines").child(currentUid!).child(key)
    }
}
