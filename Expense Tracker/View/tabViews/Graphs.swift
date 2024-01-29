//
//  Graphs.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 17/01/24.
//

import SwiftUI
import SwiftData
import Charts

struct Graphs: View {
    @Query(animation: .snappy) private var transactions: [Transactions]
    @State private var chartGroup : [ChartGroup] = []
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyVStack(spacing:10){
                    
                    chartView()
                        .frame(height:200)
                        .padding(.top,15)
                        .padding(10)
                        .background(.background , in: .rect(cornerRadius: 10))
                    
                    
                    ForEach(chartGroup) {group in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(format(date: group.date ,format:"MM-yy"))
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                                 .hSpacing(.leading)
                            CardView(income: group.totalIncome , expense: group.totalExpense)
                        }
                        
                    }
                }
                .padding(15)
            }
            .background(Color.gray.opacity(0.15))
            .navigationTitle("Graphs")

            .onAppear{
                createChartGroup()
            }
        }
    }
    @ViewBuilder
    func chartView() -> some View{
        Chart{
            ForEach(chartGroup) { group in
                ForEach(group.categories){ chart in
                    BarMark(
                        x: .value("Month", format(date: group.date, format: "MM-yy")),
                        y: .value(chart.category.rawValue, chart.totalValue),
                        width: 20
                    )
                    .position(by: .value("Category",chart.category.rawValue), axis: .horizontal)
                    .foregroundStyle(by: .value("Category",chart.category.rawValue))
                    
                }
                
            }
        }
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartLegend(position: .bottom,alignment: .trailing)
        .chartYAxis{
            AxisMarks(position: .leading){value in
                let doubleValue = value.as(Double.self) ?? 0
                AxisGridLine()
                AxisTick()
                AxisValueLabel{
                    Text(axislabel(doubleValue))
                }
                
            }
        }
        .chartForegroundStyleScale(range: [Color.green.gradient , Color.red.gradient])
    }
    
    func createChartGroup() {
        Task.detached(priority: .high) {
            let calender = Calendar.current
            let groupedByDate = Dictionary(grouping: transactions) { transaction in
                let components = calender.dateComponents([.month,.year], from: transaction.dateAdded)
                return components
            }
            let sortedGroups = groupedByDate.sorted {
                let date1 = calender.date(from: $0.key) ?? .init()
                let date2 = calender.date(from: $1.key) ?? .init()
                return calender.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            let chartGroup = sortedGroups.compactMap { dict -> ChartGroup? in
                let date = calender.date(from: dict.key) ?? .init()
                let income = dict.value.filter({$0.category == Category.income.rawValue})
                let expense = dict.value.filter({$0.category == Category.expense.rawValue})
                
                let incometotalValue = total(income, category: .income)
                let expensetotalValue = total(expense, category: .expense)
                
                return .init(categories: [
                    .init(category: .income, totalValue: incometotalValue),
                    .init(category: .expense, totalValue: expensetotalValue)
                    
                ],
                             totalIncome: incometotalValue,
                             totalExpense: expensetotalValue,
                             date: date)

                
            }
            await MainActor.run {
                self.chartGroup = chartGroup
            }
        }
        
    }
    
    func axislabel(_ value : Double) -> String{
        let kValue = Int(value) / 1000
        return "\(kValue)K"
    }
}
#Preview {
    Graphs()
}
