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
            Text("Hello World")

                .navigationBarTitle(STRING_TUPLE.22, displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            print("button pressed")
                            
                        }) {
                            Image(systemName: "arrow.left")
                                .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                .font(.title2)
                                .frame(maxWidth: 40, alignment: .leading)
                                .foregroundColor(.red)
                        }
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
