//
//  CartView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-20.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                HStack(content: {
                    Text("My Cart")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("Clear")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                })
                ForEach(1 ... 9, id: \.self) { _ in

                    HStack(spacing: 8, content: {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 100)
                        VStack {
                            HStack(spacing: 8, content: {
                                Text("Product Name")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image(systemName: "trash")
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .font(.body)
                                    .foregroundColor(Color.orange)
                                    .frame(alignment: .trailing)
                                    .clipped()
                            }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                            HStack {
                                Image(systemName: "star.fill")
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .font(.body)
                                    .foregroundColor(Color.orange)
                                    .frame(alignment: .leading)
                                    .clipped()

                                Text("(4.6)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                            HStack {
                                HStack {
                                    Button("-") {}
                                        .padding(.vertical, 4)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .foregroundColor(Color.red)
                                        .fontWeight(.bold)

                                    Text("1")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .center)

                                    Button("+") {}
                                        .padding(.vertical, 4)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .foregroundColor(Color.blue)
                                        .fontWeight(.bold)
                                }
                                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                                Text("$100")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                            }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomLeading)
                        }
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                    })
                    .padding(8)
                    .background(Color("off-white"))
                    .cornerRadius(8)
                }
            })
            .padding(12)
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
