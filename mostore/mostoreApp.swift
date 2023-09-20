//
//  mostoreApp.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

@main
struct mostoreApp: App {
    @AppStorage("appTheme") private var isDarkModeOn = false
    var body: some Scene {
        WindowGroup {
           HomeView()
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
