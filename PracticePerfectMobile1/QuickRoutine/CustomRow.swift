//
//  CustomRow.swift
//  PracticePerfectMobile1
//
//  Created by Admin on 4/13/20.
//  Copyright © 2020 JakeRuthMusic. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomRow: View {
    @State var model: CustomRowModel
    //@State var practiceItems: PracticeItems
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: { self.model.isExpanded.toggle() }){
                Text(model.practiceItem.title!)
                    .font(.system(size: 20, weight: .bold))
            }
            
//            if (model.isExpanded) {
//                HStack {
//                    Text(model.practiceItem.details! + "-" + String(model.practiceItem.minutes!))
//                    .lineLimit(nil).padding(.horizontal, 50)
//                    
//                    Button(action: {self.practiceItems.removeRow(uuid: self.model.id)}){
//                        Image(systemName: "minus.circle").font(.system(size: 22, weight: .heavy)).padding(5)
//                    }
//                }
//            } else {
//                EmptyView()
//            }
        }
    }
}
