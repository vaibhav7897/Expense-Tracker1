//
//  tintColor.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct tintColor : Identifiable
{
    let id: UUID = .init()
    let color : String
    let value : Color
}
    let tints : [tintColor] = [
        .init(color: "Red", value: .red),
        .init(color: "Pink", value: .pink),
        .init(color: "Purple", value: .purple),
        .init(color: "Blue", value: .blue),
        .init(color: "Brown", value: .brown),
        .init(color: "Orange", value: .orange)


    
    
    ]

