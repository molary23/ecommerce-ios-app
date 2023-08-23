//
//  CartView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-20.
//

import SwiftUI

func updateQty(action: String, count: Int) -> Int {
    var qty = count
    if action == "plus" {
        if qty < 10 {
            qty += 1
        }
    } else if action == "minus" {
        if qty > 0 {
            qty -= 1
        }
    }

    return qty
}

struct CartView: View {
    let qArray: [Int] = [1, 2, 1, 1, 4, 1, 5, 3, 1]

    @State private var qty: Int = 1

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20, content: {
                    ForEach(qArray, id: \.self) { index in
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
                                        .frame(alignment: .leading)
                                        .clipped()

                                    Text("(4.6)")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.indigo)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                                HStack {
                                    HStack {
                                        Button("-") {
                                         //   qty = updateQty(action: "minus", count: qty)
                                        }
                                        .padding(.vertical, 4)
                                        .frame(maxWidth: .infinity)
                                        .background(Color.white)
                                        .foregroundColor(Color.red)
                                        .fontWeight(.bold)

                                        Text("\(qArray[index])")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .frame(maxWidth: .infinity, alignment: .center)

                                        Button("+") {
                                          //  qty = updateQty(action: "plus", count: qArray[index])
                                        }
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

            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("button pressed")

                    }) {
                        Text(PAGE_TEXT["text"]![12])
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
