//
//  tab.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import Foundation
import SwiftUI

enum tab : String{
    case recents = "Recents"
    case search = "Search"

    case charts = "Charts"
    case settings = "Settings"
    
    @ViewBuilder
    var tabContent : some View{
        switch self {
        case .recents :
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .search :
            Image(systemName: "magnifyingglass")
            Text(self.rawValue)
        case .charts :
            Image(systemName: "chart.bar.fill")
            Text(self.rawValue)
        case .settings :
            Image(systemName: "gearshape")
            Text(self.rawValue)
        }
        
    }

}
