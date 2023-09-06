//
//  SettingsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-22.
//

import SwiftUI

struct SettingsView: View {
    @State private var isLogOut: Bool = false
    var body: some View {
        NavigationStack {
            List(content: {
                Section(header: Text("General"), content: {
                    NavigationLink(destination: MainView(), label: {
                        SettingRowView(title: "Account",
                                       systemImageName: "dollarsign.circle")

                    })
                    
                    Button(action: { logOut() }, label: {
                        SettingRowView(title: "Log Out",
                                       systemImageName: "power")
                        
                    })
                    .navigationDestination(isPresented: $isLogOut, destination: {LoginView()})
                    .accentColor(.red)

                })

                Section(header: Text("Display"), content: {
                    Button(action: { print(123) }, label: {
                        SettingRowView(title: "Display Mode",
                                       systemImageName: "moonphase.last.quarter")

                    })
                    .accentColor(.blue)

                })
            })

            .navigationBarTitle(PAGE_TEXT["title"]![5], displayMode: .inline)
        }
    }
    func logOut(){
        preferences.removeObject(forKey: usernameKey)
        preferences.removeObject(forKey: emailKey)
        isLogOut = true
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
