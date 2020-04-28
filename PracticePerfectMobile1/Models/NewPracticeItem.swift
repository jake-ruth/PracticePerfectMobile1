//
//  NewPracticeItem.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/27/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation

public class NewPracticeItem: Identifiable {
    public var uuid: UUID?
    public var title: String?
    public var details: String?
    public var minutes: Int = 1
    public var index: Int?
}