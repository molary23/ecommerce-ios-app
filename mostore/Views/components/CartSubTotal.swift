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
        HStack(spacing: 30) {
            HStack {
                Text("Subtotal:")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("$\(total, specifier: "%.2f")")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity)
            NavigationLink(destination: CheckoutView(), label: {
                Text(PAGE_TEXT["button"]![2])
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            })

            .disabled(total <= 0)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 100, alignment: .center)
        .background(.white)

        .clipped()
        .compositingGroup()
        .shadow(color: Color.black.opacity(0.4), radius: 1, x: 0, y: -2)
        .frame(maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
        .ignoresSafeArea(edges: .bottom)
    }
}

struct CartSubTotal_Previews: PreviewProvider {
    static var previews: some View {
        CartSubTotal(total: 0.0)
    }
}
