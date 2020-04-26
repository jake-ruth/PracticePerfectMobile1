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
    public var routineTitle: String?
    public var practiceItems: Array<String>?
    public var isFavorite: Bool?
}
