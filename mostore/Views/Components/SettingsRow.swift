//
//  SettingsRow.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct SettingsRow: View {
    var title: String
    var systemImageName: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: systemImageName)
            Text(title)
        }
    }
}

struct SettingsRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRow(title: "Settings", systemImageName: "gear")
    }
}
