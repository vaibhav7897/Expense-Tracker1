//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct ContentView: View {
    //new user check
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    @State private var activeTab: tab = .recents
    var body: some View {
        VStack {
            TabView(selection: $activeTab){
                Recents()
                    .tag(tab.recents)
                    .tabItem { tab.recents.tabContent }
                Search()
                    .tag(tab.search)
                    .tabItem { tab.search.tabContent }
                Charts()
                    .tag(tab.charts)
                    .tabItem { tab.charts.tabContent }
                Settings()
                    .tag(tab.settings)
                    .tabItem { tab.settings.tabContent }
            }
            .sheet(isPresented: $isFirstTime, content: {
                introView()
                    .interactiveDismissDisabled()
            })
        }
        .background(Color(.gray).opacity(0.15))
    }
}

#Preview {
    ContentView()
}
