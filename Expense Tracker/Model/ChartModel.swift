//
//  ChartModel.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 17/01/24.
//

import SwiftUI

struct ChartGroup :Identifiable{
    let id : UUID = .init()
    var categories : [ChartCategory]
    var totalIncome: Double
   
    var totalExpense : Double
    var date: Date
    
}

struct ChartCategory:Identifiable{
    let id : UUID = .init()
    var category : Category
    var totalValue : Double
}
