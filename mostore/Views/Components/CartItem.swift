//
//  CartItem.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import SwiftUI

struct CartItem: View {
    @StateObject var cartItemController = CartItemController()
    @EnvironmentObject var cartManager: CartManager
    let item: ProductModel
    let quantity: Int

    var body: some View {
        HStack(spacing: 8, content: {
            DataImage(imageURL: item.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))
            VStack {
                HStack(spacing: 8, content: {
                    Text("\(item.name)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)

                }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                HStack {
                    Image(systemName: item.rating > 4 ? "star.fill" : "star")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.body)
                        .frame(alignment: .leading)
                        .clipped()

                    Text("\(item.rating, specifier: "%.1f")")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.indigo)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                HStack {
                    HStack {
                        Button(action: {
                            cartItemController.removeQty(productId: item.id)
                            cartManager.removeFromCart(product: item)
                        }, label: {
                            Image(systemName: "minus")

                        })

                        .accentColor(.red)
                        .frame(width: 20, height: 20, alignment: .center)
                        .background(.white)

                        Text("\(quantity)")
                            .accessibilityLabel("Product Quantity")
                            .fontWeight(.semibold)
                            .frame(alignment: .leading)

                        Button(action: {
                            cartItemController.addQty(productId: item.id)
                            cartManager.addToCart(product: item)
                            //    cartItemController.cartItem.quantity += 1
                            //  cartController.getCartItems()
                        }, label: {
                            Image(systemName: "plus")

                        })
                        .frame(width: 20, height: 20, alignment: .center)
                        .background(.white)
                    }
                    .frame(alignment: .leading)

                    Text("$\(item.price * Double(quantity), specifier: "%.2f")")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomLeading)
            }
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        })
        .padding()
        .background(.white)
        .border(Color("off-white"))
        .cornerRadius(12)
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItem(
            item: .init(id: "", name: "", description: "", price: 0.0, image: "", rating: 0.0, createdAt: "", updatedAt: ""), quantity: 0
        )
        .environmentObject(CartManager())
    }
}
