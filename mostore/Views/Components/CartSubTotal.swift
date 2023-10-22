//
//  CartSubTotal.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import SwiftUI

struct CartSubTotal: View {
    let total: Double

    var body: some View {
        HStack(spacing: 10) {
            Text("Subtotal:")
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

            Text("$\(total, specifier: "%.2f")")
                .bold()
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)

            NavigationLink(destination: CheckoutView(), label: {
                Text(PAGE_TEXT["button"]![2])
                    .padding(.vertical, 10)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .background(total > 0 ? Color.blue : Color.gray)
                    .cornerRadius(40)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            })
            .disabled(total <= 0)
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 80, alignment: .center)
        .padding(.horizontal, 10)
        .background(Color("off-white"))

        .clipped()
        .compositingGroup()
        .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: -3)
        .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct CartSubTotal_Previews: PreviewProvider {
    static var previews: some View {
        CartSubTotal(total: 10000.0)
    }
}
