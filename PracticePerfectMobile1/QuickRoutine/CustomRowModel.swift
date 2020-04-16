//
//  NewPracticeItem.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/13/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import Combine

public struct CustomRowModel: Identifiable {
    public var id = UUID().uuidString
    var practiceItem: PracticeItemModel
    var isExpanded: Bool
}
