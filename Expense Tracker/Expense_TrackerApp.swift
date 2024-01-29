//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : [Transactions.self])
    }
}
