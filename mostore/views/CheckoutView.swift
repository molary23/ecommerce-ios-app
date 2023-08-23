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
        NavigationStack {
            ScrollView {
                Spacer()
                Spacer() 
                VStack(spacing: 50, content: {
                    VStack {
                        Text(STRING_TUPLE.14)
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

                            Text("*****  *****  *****  \(lastFour)")
                                .font(.body)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }).padding()
                            .background(Color("off-white"))
                            .cornerRadius(8)
                            .frame(width: .infinity, height: .infinity, alignment: .leading)
                    }

                    VStack {
                        HStack(content: {
                            Text(STRING_TUPLE.15)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(STRING_TUPLE.16)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                        })

                        HStack(content: {
                            Text(STRING_TUPLE.17)
                                .font(.body)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(STRING_TUPLE.18.uppercased())
                                .font(.body)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })

                        .padding(.vertical, 40)
                        .padding(.horizontal, 10)
                        .background(Color("off-white"))
                        .cornerRadius(8)
                        .frame(width: .infinity, height: .infinity, alignment: .leading)
                    }
                    VStack(spacing: 30) {
                        HStack(content: {
                            Text(STRING_TUPLE.19)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$100".uppercased())
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

                        HStack(content: {
                            Text(STRING_TUPLE.20)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("$20".uppercased())
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        })
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

                        HStack(content: {
                            Text(STRING_TUPLE.21)
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
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            .navigationBarTitle(STRING_TUPLE.13, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("button pressed")

                    }) {
                        Image(systemName: "arrow.left")
                            .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                            .font(.title2)
                            .frame(maxWidth: 40, alignment: .leading)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
