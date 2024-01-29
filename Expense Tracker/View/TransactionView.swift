//
//  NewExpenseView.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 17/01/24.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    
    var editTransaction : Transactions?
    
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
                                customSection("Title",hint:"Enter title" ,value: $title)
                                customSection("Remarks",hint:"Enter description", value: $remarks)
            
                                //amount and category check box
                                VStack(alignment: .leading, spacing:10){
                                    Text("Amount and category")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                        .hSpacing(.leading)
                                    HStack{
                                        HStack(spacing:4){
                                            Text(currencySymbol)
                                                .font(.callout.bold())
                                            TextField("0.0", value: $amount, formatter: numberFormatter)
                                                .keyboardType(.decimalPad)
                
                                        }
                                        .padding(.horizontal,15)
                                        .padding(.vertical,12)
                                        .background(.background , in: .rect(cornerRadius: 10))
                                        .frame(maxWidth: 130)
                
                
                                        customCheckBox()
                                    }
                                }
                                //date picker
                                VStack(alignment: .leading, spacing:10){
                                    Text("Date")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                        .hSpacing(.leading)
                                    DatePicker("", selection: $dateAdded, displayedComponents: [.date])
                                        .datePickerStyle(.graphical)
                
                                }
                
                            }
                            .padding(15)
                        }
                        .navigationTitle("\(editTransaction == nil ? "Add" : "Edit") Transactions")
                        .background(Color.gray.opacity(0.15))
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarTrailing){
                                Button("Save"){
                                    save()
                                }
                            }
                        })
                        .onAppear(perform: {
                            if let editTransaction {
                                 title = editTransaction.title
                                remarks = editTransaction.remarks
                                dateAdded = editTransaction.dateAdded
                                amount =  editTransaction.amount
//                                if let tint = editTransaction.tint{
//                                    self.tint = tint
//                                }
                                if let category = editTransaction.rawCategory{
                                    self.category = category
                                }
                
                            }
                        })
                    }
                    func save(){
                        if editTransaction != nil{
                            editTransaction?.title = title
                            editTransaction?.remarks = remarks
                            editTransaction?.amount = amount
                            editTransaction?.dateAdded = dateAdded
                            editTransaction?.category = category.rawValue
                
                        }
                        else{
                            let transaction = Transactions(title: title, remarks: remarks, amount: amount, dateAdded: dateAdded, category: category, tintColor: tint)
                            context.insert(transaction)
                        }
                        
                
                        dismiss()
                    }
                
                
                    //title and remarks field
                    @ViewBuilder
                    func customSection(_ title: String ,hint : String, value: Binding<String>) -> some View{
                        VStack(alignment: .leading , spacing: 10){
                            Text(title)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .hSpacing(.leading)
                            TextField(hint, text: value)
                                .padding(.horizontal,15)
                                .padding(.vertical,12)
                                .background(.background , in: .rect(cornerRadius: 10))
                        }
                    }
                
                    @ViewBuilder
                    func customCheckBox() -> some View{
                        HStack(spacing : 10){
                            ForEach(Category.allCases , id: \.rawValue){ category in
                                HStack(spacing:5){
                                    ZStack{
                                        Image(systemName: "circle")
                                            .font(.title)
                                            .foregroundStyle(appTint)
                                        if self.category == category {
                                            Image(systemName: "circle.fill")
                                                .font(.caption)
                                                .foregroundStyle(appTint)
                                        }
                                    }
                                    Text(category.rawValue)
                                        .font(.caption)
                
                                }
                                .contentShape(.rect)
                                .onTapGesture {
                                    self.category = category
                                }
                
                            }
                        }
                        .padding(.horizontal,15)
                        .padding(.vertical,12)
                        .hSpacing(.leading)
                        .background(.background , in: .rect(cornerRadius: 10))
                
                    }
                    /// number formatter
                    var numberFormatter: NumberFormatter {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        formatter.maximumFractionDigits = 2
                        return formatter
                    }
                
            }
        
#Preview {
    NavigationStack{
        TransactionView()
    }
}
