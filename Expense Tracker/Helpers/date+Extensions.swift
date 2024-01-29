//
//  date+Extensions.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

extension Date{
    var startOfMonth: Date{
        let components = Calendar.current.dateComponents([.year , .month], from: self)
        return Calendar.current.date(from: components) ?? self
    }
    var endOfMonth: Date{
        return Calendar.current.date(byAdding: .init(month: 1 ,minute : -1), to: self.startOfMonth) ?? self
    }
}
