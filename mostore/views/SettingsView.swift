//
//  SettingsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-22.
//

import SwiftUI

struct SettingsView: View {
    @State private var isLogOut: Bool = false

    // @State var theColorScheme: ColorScheme = .dark
    @AppStorage("appTheme") private var isDarkModeOn = false

    @State var showSheet = false
    @State var isDark = true
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
                    Button(action: {
                        showSheet = true
                    }, label: {
                        SettingsRow(title: "Display Mode",
                                    systemImageName: "moonphase.first.quarter")

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
            .actionSheet(isPresented: $showSheet, content: getActionSheet)

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

    func getActionSheet() -> ActionSheet {
        let darkMode: ActionSheet.Button = .default(
            Text("Dark Mode")
        ) {
            isDarkModeOn = true
        }

        let lightMode: ActionSheet.Button = .default(
            Text("Light Mode")
        ) {
            isDarkModeOn = false
        }

        let useCancel: ActionSheet.Button = .cancel({ showSheet = false })

        return ActionSheet(title: Text("Display Mode"), message: Text("You can change the Display Mode"), buttons: [darkMode, lightMode, useCancel])
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
