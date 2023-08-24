//
//  CheckoutView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct CheckoutView: View {
    var lastFour: Int = 5555
    @State private var expiry: String = ""
    @State private var cvv: String = ""
    @State private var cardNumber: String = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer()
                Spacer()
                VStack(spacing: 50, content: {
                    VStack {
                        Text(PAGE_TEXT["text"]![3])
                            .font(.headline)
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

                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![9], placement: .trailing, id: "cardNumber", value: $cardNumber).textFieldStyle(.plain)

                        }).padding()
                            .background(Color("off-white"))
                            .cornerRadius(8)
                            .frame(width: .infinity, height: .infinity, alignment: .leading)
                    }

                    VStack {
                        HStack(content: {
                            Text(PAGE_TEXT["text"]![4])
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(PAGE_TEXT["text"]![5])
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                        })

                        HStack(content: {
                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![5], placement: .leading, id: "expiry", value: $expiry).textFieldStyle(.plain)

                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![6], placement: .trailing, id: "cvv", value: $cvv).textFieldStyle(.plain)

                        })

                        .padding(.vertical, 40)
                        .padding(.horizontal, 10)
                        .background(Color("off-white"))
                        .cornerRadius(8)
                        .frame(width: .infinity, height: .infinity, alignment: .leading)
                    }
                    VStack(spacing: 30) {
                        ExtTotalView(heading: PAGE_TEXT["text"]![6], amount: 100)
                        ExtTotalView(heading: PAGE_TEXT["text"]![7], amount: 20)
                        ExtTotalView(heading: PAGE_TEXT["text"]![8], amount: 120)
                    }

                    Spacer()

                    Button(PAGE_TEXT["button"]![3]) {}
                        .padding(.vertical, 15.0)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .font(.title2)
                })
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            .navigationBarTitle(PAGE_TEXT["title"]![3], displayMode: .inline)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
