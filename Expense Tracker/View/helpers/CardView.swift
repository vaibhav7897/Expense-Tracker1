//
//  CardView.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense :  Double
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
            VStack(spacing:0){
                HStack(spacing: 12){
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                    Image(systemName: (expense > income) ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis" )
                        .font(.title)
                        .foregroundStyle(expense > income ? .red : .green)
                }
                .padding(.bottom,25)
                HStack(spacing:10){
                    ForEach(Category.allCases, id: \.rawValue){components in
                        let symbolImage = components == .income ? "arrow.down": "arrow.up"
                        let tint = components == .income ? Color.green : Color.red
                        HStack(spacing:10){
                            Image(systemName: symbolImage)
                                .font(.callout.bold())
                                .foregroundStyle(tint)
                                .frame(width: 35,height: 35)
                                .background(tint.opacity(0.25).gradient, in: .circle)
                        }
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(components.rawValue)
                                .font(.caption2)
                                .foregroundStyle(.gray)
                            Text(currencyString(components == .income ? income : expense ,allowedDigits:0))
                                .font(.callout)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                        }
                        if components == .income {
                            Spacer()
                        }
                    }
                }
                .padding(.bottom,25)

            }
            .padding(.horizontal,25)
            .padding(.top,15)

            
            
        }
    }
}

#Preview {
    CardView(income: 4444, expense: 2222)
}
