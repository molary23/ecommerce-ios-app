//
//  TotalRow.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct TotalRow: View {
    var heading: String
    var amount: Double
    var body: some View {
        HStack(content: {
            Text(heading)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("$\(amount, specifier: "%0.2f")")
                .font(.body)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
        })
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)
    }
}

struct TotalRow_Previews: PreviewProvider {
    static var previews: some View {
        TotalRow(heading: "Total", amount: 45.66)
    }
}
