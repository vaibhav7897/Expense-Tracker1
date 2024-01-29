//
//  view+Extension.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity,alignment: alignment)
    }
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity , alignment: alignment)
    }
    
    var safeArea : UIEdgeInsets{
        if let windowScene  = (UIApplication.shared.connectedScenes.first as? UIWindowScene){
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
        
    }
    func format(date: Date, format : String) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    func currencyString(_ value: Double , allowedDigits : Int = 2) -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = allowedDigits
        return formatter.string(from: .init(value: value)) ?? ""
        
    }
    var currencySymbol : String{
        let currency = Locale.current
        return currency.currencySymbol ?? ""
    }
    
    func total(_ transaction : [Transactions] , category : Category) -> Double{
        return transaction.filter({$0.category == category.rawValue}).reduce(Double.zero) { partialResult, transaction in
            return partialResult + transaction.amount
        }
    }
}
