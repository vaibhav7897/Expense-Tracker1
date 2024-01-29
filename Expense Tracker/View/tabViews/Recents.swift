//
//  Recents.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI
import SwiftData

struct Recents: View {
    @Environment(\.modelContext) private var context
    @AppStorage("userName") private var userName : String = ""
    @State private var startdate : Date = .now.startOfMonth
    @State private var enddate : Date = .now.endOfMonth
    @State private var showFilteredView: Bool = false
    @State private var selectedCategory : Category = .expense
    //for animations
    @Namespace private var animation
//    @Query(sort: [SortDescriptor(\Transaction.dateAdded , order: .reverse)], animation: .snappy) private var transactions
    @Query(sort: [SortDescriptor(\Transactions.dateAdded, order: .reverse)],  animation: .snappy) private var transaction : [Transactions]

    var body: some View {
        GeometryReader{
            let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical){
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]){
                        Section{
                            Button{
                                //action
                                showFilteredView = true
                            }label: {
                                Text("\(format(date:startdate, format:"dd MM yyyy")) to \(format(date:enddate, format:"dd MM yyyy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            }
                            .hSpacing(.leading)
                            FilterTransactionView(startDate: startdate, endDate: enddate) { transaction in
                                //card view
                                CardView(
                                    income: total(transaction, category: .income),
                                    expense: total(transaction, category: .expense)
                                )
                            }
                            //segmented view
                            CustomSegmentedControl()
                                .padding(.bottom,10)
                            //                            ForEach(sampleTractions.filter({$0.category == selectedCategory.rawValue })){ transaction in
                            //                            transactionCardView(transaction: transaction)
                            //                            }
                            ForEach(transaction.filter({$0.category == selectedCategory.rawValue})){transaction in
                                NavigationLink{
                                    TransactionView(editTransaction : transaction)
                                }label: {
                                    transactionCardView(transaction: transaction)
                                    
                                }
                                .buttonStyle(.plain)
//                                .onDelete { indexes in
//                                    for index in indexes{
//                                        deleteItem(transaction[index])
//                                    }
//                                }
                                
                            }
                            
                        
                            

                            
                        
                            
                        }header: {
                            //header view
                            HeaderView(size)
                        }
                    }
                    .padding(.horizontal,15)
                    
                }
                .background(Color.gray.opacity(0.15))
                .blur(radius: showFilteredView ? 8 : 0)
                .disabled(showFilteredView)
                
            }
            .overlay{
                if showFilteredView{
                    ZStack{
                        DateFilterView(start: startdate, end: enddate, onSubmit: { start, end in
                            startdate = start
                            enddate = end
                            showFilteredView = false
                        }, onCancel: {
                            showFilteredView = false

                        })
                            .transition(.move(edge: .leading))
                    }
                }
            }
        }

        
    }
    @ViewBuilder
    func HeaderView(_ size : CGSize) -> some View{
        
        HStack(spacing: 10){
            VStack(alignment: .leading,spacing: 5){
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty{
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                }
            }
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            Spacer(minLength: 0)
            //        .hSpacing(.leading)
            //        .overlay(alignment: .trailing, content: {
            NavigationLink{
                TransactionView()
            }label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .frame(width: 45,height: 45)
                    .background(appTint, in: .circle)
                    .contentShape(.circle)
                
            }
            
            
        }
       
        .padding(.bottom,5)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .padding(.horizontal,-15)
                .padding(.top , -(safeArea.top + 15))
            //                .padding(safeArea.top + 15)
            
        }
    }
    
    @ViewBuilder
    func CustomSegmentedControl() -> some View{
        HStack(spacing: 0){
            ForEach(Category.allCases , id: \.rawValue){components in
                Text(components.rawValue)
                    .hSpacing()
                    .padding(.vertical,10)
                    .background{
                        if components == selectedCategory{
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ActiveTab", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy){
                            selectedCategory = components
                        }
                    }
            }
        }
        .background(Color.gray.opacity(0.15), in: .capsule)
        .padding(.top,5)
    }
    
   
    
    func headerScale(_ size : CGSize,proxy : GeometryProxy) -> CGFloat{
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY/screenHeight
        let scale = (min(max(progress,0),1)) * 0.9
        return 1 + scale
    }
    func deleteItem(_ item : Transactions){
        context.delete(item)
    }
   
    
}

#Preview {
    Recents()
}
