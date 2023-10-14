//
//  CartView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-20.
//

import SwiftUI

struct CartView: View {
    @StateObject var cartController = CartController()
    @EnvironmentObject var cartManager: CartManager

    init() { }

    var body: some View {
        NavigationStack {
            VStack {
                if cartManager.products.isEmpty && cartController.isCartEmpty {
                    NoItemsFound(text: PAGE_TEXT["text"]![15])
                }

                List(cartManager.singleProductOccurence) { item in
                    CartItem(item: item, quantity: cartManager.products.filter { $0.id == item.id }.count)
                        .buttonStyle(.borderless)
                        .padding(.bottom, 8)
                        .listRowBackground(Color.clear)

                        .swipeActions(content: {
                            Button("Delete") {
                                cartManager.removeProductFromCart(product: item)
                                cartController.removeProductFromCart(productId: item.id)
                            }.tint(.red)

                        })

                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                 .frame(maxHeight: .greatestFiniteMagnitude)

                
                   

                // .alert(isPresented: $cartController.showAlert, content: getAlert)
            }
            .overlay(
                CartSubTotal(total: cartManager.products.map({ $0.price }).reduce(0, +))
                    .frame(maxHeight: 50)
                , alignment: .bottom)
            

            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        cartController.showAlert = true
                    }, label: {
                        Text(PAGE_TEXT["button"]![4])
                            .foregroundColor(Color.red)
                            .fontWeight(.bold)

                    })
                }
            }
        }
    }

    func getAlert() -> Alert {
        let primaryButton: Alert.Button = .cancel()
        let secondaryButton: Alert.Button = .destructive(Text("Clear All")) {
            cartManager.removeAllFromCart()
            cartController.deleteAllOrder()
            cartController.isCartEmpty = true
        }

        return Alert(title: Text("Clear Cart"), message: Text("Are you sure you want to clear all items in Cart?"), primaryButton: primaryButton, secondaryButton: secondaryButton)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
