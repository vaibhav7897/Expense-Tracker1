//
//  introView.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct introView: View {
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    var body: some View {
        VStack(spacing:15){
            Text("What's new in the expense Tracker?")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top,65)
                .padding(.bottom,35)
            VStack(alignment: .leading , spacing: 25){
                pointView(symbol: "dollarsign", title: "Transactions", subTitle: "Keeps track of your earnings and expenses ")
                pointView(symbol: "chart.bar.fill", title: "Visual Charts", subTitle: "View your Transction using eye catching graphic representaion")
                pointView(symbol: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expense you want using search and filtering")
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal,25)
            
            Spacer(minLength: 10)
            
            Button{
                isFirstTime = false
            }label: {
                Text("Continue")
                    .bold()
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)

                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(15)
            
            
        }
        
    }
    @ViewBuilder
    func pointView(symbol: String, title: String, subTitle: String) -> some View{
        HStack(spacing:15){
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width:45)
            VStack(alignment: .leading,spacing: 6){
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundStyle(Color.gray)
            }
            
        }
    }
}

#Preview {
    introView()
}
