//
//  Settings.swift
//  Expense Tracker
//
//  Created by Vaibhav Gupta on 16/01/24.
//

import SwiftUI

struct Settings: View {
    @AppStorage("userName") private var userName : String = ""
    @AppStorage("isAppLockedEnabled") private var isAppLockedEnabled : Bool = false
    @AppStorage("lockWhenAppGoesbackground") private var lockWhenAppGoesbackground : Bool = false
    
    
    var body: some View {
        NavigationStack{
            List{
                Section("User Name"){
                    TextField("Vaibhav", text: $userName)
                }
                Section("App Lock"){
                    Toggle("Enable App Lock", isOn: $isAppLockedEnabled)
                    if isAppLockedEnabled{
                        Toggle("Lock When App Goes background", isOn: $lockWhenAppGoesbackground)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
#Preview {
    Settings()
}
