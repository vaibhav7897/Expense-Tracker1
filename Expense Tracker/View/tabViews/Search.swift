//
//  Search.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI
import Combine

struct Search: View {
    @State private var searchtext : String = ""
    @State private var filterText : String = ""
    @State private var selectedCategory : Category? = nil
    let searchPublisher = PassthroughSubject<String,Never>()

    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyVStack(spacing:12){
                    FilterTransactionView(category: selectedCategory, searchText: filterText) { transactions in
                        ForEach(transactions){ transaction in
                            NavigationLink{
                                TransactionView(editTransaction: transaction)
                            }label: {
                                transactionCardView(transaction: transaction,showCategory: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.top,20)
                
            }
            .overlay(content: {
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1:0)
            })
            .onChange(of: searchtext, { oldValue, newValue in
                if newValue.isEmpty{
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
            })
            .searchable(text: $searchtext)
            .navigationTitle("Search")
            .background(Color.gray.opacity(0.15))
//            .toolbar{
//                ToolbarItem(placement: .topTrailing){
//                    toolBarContent()
//                }
//            }
//            .toolbar{
//                ToolbarItem(placement: .topBarTrailing) {
//                    toolBarContent()
//                }
//            }
        }
    }
//    @ViewBuilder
//    func toolBarContent() -> some View{
//        Menu{
//            Button{
//                selectedCategory = nil
//            }label: {
//                HStack{
//                    Text("Both")
//                    if selectedCategory == nil{
//                        Image(systemName: "checkmark")
//                    }
//                }
//            }
//            ForEach(Category.allCases , id: \.rawValue){ category in
//                Button{
//                    selectedCategory = category
//                }label: {
//                    HStack{
//                        Text(category.rawValue)
//                        if selectedCategory == category{
//                            Image(systemName: "checkmark")
//                        }
//                    }
//                }
//            }
//        }label: {
//            Image(systemName: "slider.vertical.3")
//        }
//    }
}

#Preview {
    Search()
}
