//
//  PlayRoutineUtil.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 5/2/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation

class PlayRoutineUtil {
    static func secondsBetweenDates(_ oldDate: Date, _ newDate: Date) -> Int {
        //get both times sinces refrenced date and divide by 60 to get minutes
        let newDateSeconds = newDate.timeIntervalSinceReferenceDate
        let oldDateSeconds = oldDate.timeIntervalSinceReferenceDate
        
        //then return the difference
        return Int(newDateSeconds - oldDateSeconds)
    }
}
