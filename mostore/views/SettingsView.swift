//
//  SettingsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List(content: {
                Section(header: Text("General"), content: {
                    NavigationLink(destination: MainView(), label: {
                        SettingRowView(title: "Account",
                                       systemImageName: "dollarsign.circle")

                    })

                })

                Section(header: Text("Display"), content: {
                    Button(action: { print(123) }, label: {
                        SettingRowView(title: "Display Mode",
                                       systemImageName: "moonphase.last.quarter")

                    })
                    .accentColor(.red)

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
