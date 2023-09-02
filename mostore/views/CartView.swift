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
    // @State private var productArray = Array(productData.enumerated())
    @State var carts = [CartData]()

    var body: some View {
        NavigationStack {
            ZStack {
                //    if !carts.isEmpty {
                ScrollView {
                    VStack(spacing: 20, content: {
                        ForEach(carts) { item in
                            CartItem(product: item)
                        }
                    })
                    .padding(12)
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    .onAppear {
                        CartApi().loadData(orderId: "64ee5e9cc2670c716019c428") { carts in
                            self.carts = carts
                            print(carts)
                        }
                    }
                }.overlay(
                    FloatingButton(action: {
                        //  product.removeAll()
                    }, icon: "trash.slash", fg: Color.white, bg: Color.red, label: "Remove from cart"))

                /*   } else {
                     NoItemLayout
                 }*/
            }
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
    //   @Binding var productArray: Array<(offset: Int, element: SimpleProduct)>
    //  @Binding var allProductData: [CartData]
    let product: CartData
    var body: some View {
        HStack(spacing: 8, content: {
         /*   AsyncImage(url: URL(string: product.image.components(separatedBy: "|")[0])!, placeholder: {
                ProgressView()
            })
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .cornerRadius(8.0)*/

            VStack {
                HStack(spacing: 8, content: {
                    Text("\(product.name)")
                        .font(.body)
                        .fontWeight(.bold)

                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Button(action: {
                        /* if !productArray.isEmpty {
                         productArray = productArray.filter({ $0.element != self.allProductData[i]
                             */
                        //    })

                        // }
                        print(123)
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
                            //   self.allProductData[i].qty = updateQty(action: "minus", count: self.allProductData[i].qty)
                        }
                        .padding(.vertical, 4)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(Color.red)
                        .fontWeight(.bold)

                        Text("\(1)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .center)

                        Button("+") {
                            //  self.allProductData[i].qty = updateQty(action: "plus", count: self.allProductData[i].qty)
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
