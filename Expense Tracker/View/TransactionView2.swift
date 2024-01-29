//
//  TransactionView2.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 18/01/24.
//

import SwiftUI
import SwiftData

struct TransactionView2: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var amount: Double = .zero
    @State private var dateAdded: Date = .now
    @State private var category : Category = .expense
    @State var tint :tintColor = tints.randomElement()!
    
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing:15){
                Text("Preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
//                transactionCardView(transaction: .init(title: title,
//                                                       remarks: remarks,
//                                                       amount: amount,
//                                                       dateAdded: dateAdded,
//                                                       category: .expense,
//                                                       tintColor: tint)
//                )
                transactionCardView(transaction: .init(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: .expense,tintColor: tintColor(color: "red", value: .red)))
            }
        }
    }
}
#Preview {
    NavigationStack{
        TransactionView2()

    }
}
