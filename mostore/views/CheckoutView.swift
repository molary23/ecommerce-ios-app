//
//  CheckoutView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct CheckoutView: View {
    var lastFour: Int = 5555
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Payment".uppercased())
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()

                VStack(spacing: 30, content: {
                    Text("Card Number")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(content: {
                        Circle()
                            .frame(maxWidth: 80, maxHeight: 80, alignment: .leading)
                            .foregroundColor(.white)
                            .overlay {
                                Image(systemName: "creditcard")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }

                        Text("*****  *****  *****  \(lastFour)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }).padding()
                        .background(Color("off-white"))
                        .cornerRadius(8)
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

                    HStack(content: {
                        Text("Expiration")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Secure Code")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .trailing)

                    })

                    HStack(content: {
                        Text("MM/YY".uppercased())
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("CVV".uppercased())
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    })
                    .padding(.vertical, 40)
                    .padding(.horizontal, 10)
                    .background(Color("off-white"))
                    .cornerRadius(8)
                    .frame(width: .infinity, height: .infinity, alignment: .leading)

                    VStack(spacing: 30) {
                        HStack(content: {
                            Text("Subtotal")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$100".uppercased())
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

                        HStack(content: {
                            Text("Tax")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$20".uppercased())
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

                        HStack(content: {
                            Text("Total")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$120".uppercased())
                                .font(.title)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .frame(width: .infinity, height: .infinity, alignment: .leading)
                    }

                    Spacer()
                    Button(STRING_TUPLE.7) {}
                        .padding(.vertical, 15.0)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.title2)
                })
            }
            .padding(20)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
