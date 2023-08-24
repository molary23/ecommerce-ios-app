//
//  SettingsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-22.
//

import SwiftUI

struct SettingRowView : View {
    var title : String
    var systemImageName : String
    
    var body : some View {
        HStack (spacing : 15) {
            Image(systemName: systemImageName)
            Text (title)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            Text("Hello World")

            List(content: {
                Section(header: Text("General"), content: {
                    NavigationLink(destination: MainView(),label: {
                        
                        SettingRowView(title: "Profit & Loss",
                                       systemImageName:"dollarsign.circle")
                        
                        
                    })
                    
                })
            })

            .navigationBarTitle(PAGE_TEXT["title"]![5], displayMode: .inline)
        
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
