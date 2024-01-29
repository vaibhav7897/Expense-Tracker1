//
//  transactionCardView.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct transactionCardView: View {
    var transaction: Transactions
    var showCategory : Bool = false
    var body: some View {
        HStack(spacing: 12){
            Text("\(String((transaction.title.prefix(1))))")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width:45,height: 45)
                .background(transaction.color.gradient, in: .circle)
            VStack(alignment: .leading ,spacing: 4){
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
                Text("\(format(date: transaction.dateAdded, format:"dd-MM-yyyy") )")
                    .font(.caption2)
                    .foregroundStyle(Color.primary.secondary)
                if showCategory{
                    Text(transaction.category)
                        .font(.caption)
                        .foregroundStyle(Color.white)
                        .padding(.horizontal,5)
                        .padding(.vertical,2)
                        .background(transaction.category == Category.income.rawValue ? Color.green.opacity(0.5) : Color.red.opacity(0.5) , in: .capsule)
                }
            }
            .lineLimit(1)
            .hSpacing(.leading)
            Text(currencyString( transaction.amount  ,allowedDigits:2))
        }
        .padding(.horizontal)
        .padding(.vertical,10)
        .background(.background, in: .rect(cornerRadius: 10))
    }
//    private func deleteFood(offsets: IndexSet){
//        withAnimation {
//            offsets.map { transaction[$0] }
//            
//        }
//    }
//        
}

//#Preview {
//    transactionCardView(transaction: sampleTractions[0])
//}
