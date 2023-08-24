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

struct SimpleProduct: Hashable {
    var id = UUID()
    var name: String
    var price: Float
    var rating: Float
    var qty: Int = 1
}

var productData = [
    SimpleProduct(name: "small top", price: 23.86, rating: 4.7),
    SimpleProduct(name: "long top", price: 30.98, rating: 3.9),
    SimpleProduct(name: "medium top", price: 25.00, rating: 5.0),
    SimpleProduct(name: "small bottom", price: 40.77, rating: 4.9),
    SimpleProduct(name: "Crop top", price: 20.20, rating: 4.2),
    SimpleProduct(name: "Dinner top", price: 15.99, rating: 4.8),
    SimpleProduct(name: "Brunch top", price: 19.90, rating: 3.5),
    SimpleProduct(name: "Summer top", price: 50.99, rating: 4.6),
]

struct CartView: View {
    @State private var allProductData = productData
    @State private var productArray = Array(productData.enumerated())

    var body: some View {
        NavigationStack {
            ScrollView {
                if !productArray.isEmpty {
                    VStack(spacing: 20, content: {
                        ForEach(productArray, id: \.element) { i, product in
                            CartItem(productArray: $productArray, allProductData: $allProductData, product: product, i: i)
                        }
                    })
                    .padding(12)
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)

                } else {
                    Text(PAGE_TEXT["text"]![15])
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                }
            }
            .overlay(
                FloatingButton(action: {
                    productArray.removeAll()
                }, icon: "trash.slash", fg: Color.white, bg: Color.blue, label: "Add to cart")
            )

            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CheckoutView(), label: {
                        HStack {
                            Text(PAGE_TEXT["button"]![2])
                                .foregroundColor(Color.blue)
                                .fontWeight(.bold)
                        }

                    })
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

struct CartItem: View {
    @Binding var productArray: Array<(offset: Int, element: SimpleProduct)>
    @Binding var allProductData: [SimpleProduct]
    let product: SimpleProduct
    let i: Int

    var body: some View {
        HStack(spacing: 8, content: {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 100, height: 100)
            VStack {
                HStack(spacing: 8, content: {
                    Text("\(product.name) + \(i)".capitalized)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Button(action: {
                        if !productArray.isEmpty {
                            productArray = productArray.filter({ $0.element != self.allProductData[i] })
                        }

                    }) {
                        Image(systemName: "trash")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .foregroundColor(Color.orange)
                            .frame(alignment: .trailing)
                            .clipped()
                    }
                }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                HStack {
                    Image(systemName: product.rating > 4 ? "star.fill" : "star")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.body)
                        .frame(alignment: .leading)
                        // .foregroundColor(Color.red)
                        .clipped()

                    Text("\(product.rating, specifier: "%.1f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                HStack {
                    HStack {
                        Button("-") {
                            self.allProductData[i].qty = updateQty(action: "minus", count: self.allProductData[i].qty)
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.red)
                        .fontWeight(.bold)

                        Text("\(self.allProductData[i].qty)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Button("+") {
                            self.allProductData[i].qty = updateQty(action: "plus", count: self.allProductData[i].qty)
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .fontWeight(.bold)
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                    Text("$\(product.price, specifier: "%.2f")")
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
}
