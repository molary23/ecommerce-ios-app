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
                    NavigationLink(destination: ProductView(), label: {
                        SettingsRow(title: "Payment Details",
                                    systemImageName: "dollarsign.circle")

                    })

                })

                Section(header: Text("Display"), content: {
                    Button(action: { print(123) }, label: {
                        SettingsRow(title: "Display Mode",
                                    systemImageName: "moonphase.last.quarter")

                    })
                    .accentColor(.blue)

                })

                Section(header: Text("Account"), content: {
                    Button(action: { logOut() }, label: {
                        SettingsRow(title: "Log Out",
                                    systemImageName: "power")

                    })
                    .navigationDestination(isPresented: $isLogOut, destination: { LoginView() })
                    .accentColor(.red)
                })
            })

            .navigationBarTitle(PAGE_TEXT["title"]![5], displayMode: .inline)
        }
    }

    func logOut() {
        preferences.removeObject(forKey: usernameKey)
        preferences.removeObject(forKey: emailKey)
        preferences.removeObject(forKey: idKey)
        removeCard()
        isLogOut = true
    }

    func removeCard() {
        preferences.removeObject(forKey: numberKey)
        preferences.removeObject(forKey: monthKey)
        preferences.removeObject(forKey: yearKey)
        preferences.removeObject(forKey: cvvKey)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
