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
    //  @State private var productArray = Array(carts.enumerated())
    @State var carts = [CartData]()

    var body: some View {
        NavigationStack {
            ZStack {
                if carts.isEmpty {
                    NoItemLayout
                }
                ScrollView {
                    VStack(spacing: 20, content: {
                        ForEach(carts, id: \.self) { item in
                            CartItem(cart: item, carts: $carts)
                        }
                    })
                    .padding(12)
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    .onAppear {
                        CartApi().loadData(orderId: "64f2a35e89ece621daa0a330") { carts in
                            self.carts = carts
                        }
                    }
                }.overlay(
                    FloatingButton(action: {
                        //  product.removeAll()
                    }, icon: "chevron.right", fg: Color.white, bg: Color.blue, label: "Proceed to Checkout"))
            }
            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        carts.removeAll()
                    }, label: {
                        Text(PAGE_TEXT["button"]![4])
                            .foregroundColor(Color.red)
                            .fontWeight(.bold)

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
    var cart: CartData
    @Binding var carts: [CartData]
    var body: some View {
        HStack(spacing: 8, content: {
            ExtAsyncImage(imageURL: cart.product.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))

            VStack {
                HStack(spacing: 8, content: {
                    Text("\(cart.product.name)")
                        .font(.body)
                        .fontWeight(.bold)

                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Button(action: {
                        carts = carts.filter({ $0.product.id != cart.product.id })

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
                    Image(systemName: cart.product.rating > 4 ? "star.fill" : "star")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.body)
                        .frame(alignment: .leading)
                        .clipped()

                    Text("\(cart.product.rating, specifier: "%.1f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                HStack {
                    HStack {
                        Button("-") {
                            //   self.allProductData[i].qty = updateQty(action: "minus", count: self.allProductData[i].qty)
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.red)
                        .fontWeight(.bold)

                        Text("\(cart.quantity)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Button("+") {
                            if var row = carts.first(where: { $0.product.id != cart.product.id }) {
                            }
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .fontWeight(.bold)
                    }
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                    Text("$\(cart.product.price, specifier: "%.2f")")
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
