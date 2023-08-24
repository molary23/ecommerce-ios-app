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

                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![9], placement: .trailing, value: $cardNumber)

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
                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![5], placement: .leading, value: $expiry)

                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![6], placement: .trailing, value: $cvv)

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

struct ExtTextFieldView: View {
    let placeholder: String
    let placement: TextAlignment
    @Binding var value: String
    var body: some View {
        TextField(placeholder, text: $value)
            .textFieldStyle(.plain)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
            .multilineTextAlignment(placement)
    }
}

struct ExtTotalView: View {
    var heading: String
    var amount: Int
    var body: some View {
        HStack(content: {
            Text(heading)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("$\(amount)")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
        .frame(width: .infinity, height: .infinity, alignment: .leading)
    }
}
