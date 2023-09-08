//
//  CartView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-20.
//

import SwiftUI

struct CartView: View {
    @State var carts: [CartData] = []
    @State var isCartEmpty: Bool = false
    @State private var quantity: String = ""
    @State private var hasCartUpdate: Bool = true
    @State private var gotoCheckout: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {
                if isCartEmpty && carts.isEmpty {
                    NotFoundLayout(text: PAGE_TEXT["text"]![15])
                }
                ScrollView {
                    ForEach(carts) { item in
                        HStack(spacing: 8, content: {
                            ExtAsyncImage(imageURL: item.product.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))
                            VStack {
                                HStack(spacing: 8, content: {
                                    Text("\(item.product.name)")
                                        .font(.system(size: 16))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)

                                    Button(action: {
                                        removeFromCart(productId: item.product.id)
                                        carts = carts.filter({ $0.product.id != item.product.id })
                                        if(carts.isEmpty){
                                            isCartEmpty = true
                                        }
                                    }, label: {
                                        Image(systemName: "trash")

                                    })
                                    .accentColor(.red)
                                    .frame(alignment: .trailing)

                                }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
                                HStack {
                                    Image(systemName: item.product.rating > 4 ? "star.fill" : "star")
                                        .renderingMode(.original)
                                        .aspectRatio(contentMode: .fit)
                                        .font(.body)
                                        .frame(alignment: .leading)
                                        .clipped()

                                    Text("\(item.product.rating, specifier: "%.1f")")
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.indigo)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                                HStack {
                                    HStack {
                                        Text("Quantity:")
                                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                                        Text("\(item.quantity)")
                                            .accessibilityLabel("Product Quantity")
                                            .fontWeight(.semibold)
                                            .frame(alignment: .leading)
                                    }
                                    .frame(alignment: .leading)

                                    Text("$\(item.product.price, specifier: "%.2f")")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
                                }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomLeading)
                            }
                            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                        })
                        .padding()
                        .background(Color("off-white"))
                        .cornerRadius(8)
                    }
                }
                .onAppear {
                    CartApi().loadCartData(userId: storedId) { carts in
                        if carts.isEmpty {
                            isCartEmpty = true
                        } else {
                            self.carts = carts
                        }
                    }
                }
                .refreshable(action: {
                    CartApi().loadCartData(userId: storedId) { carts in
                        if carts.isEmpty {
                            isCartEmpty = true
                        } else {
                            self.carts = carts
                        }
                    }
                })

                .frame(maxHeight: .greatestFiniteMagnitude)
                .overlay(
                    NavigationLink(destination: CheckoutView(), label: {
                        Text(PAGE_TEXT["button"]![5])
                            .padding(.vertical, 15.0)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .foregroundColor(Color.white)
                            .fontWeight(.bold)
                    })
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    .disabled(isCartEmpty)
                )
            }
            .padding(.horizontal, 20)
            .navigationBarTitle(PAGE_TEXT["text"]![11], displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        carts.removeAll()
                        isCartEmpty = true
                        CartApi().deleteAllOrder(userId: storedId)
                    }, label: {
                        Text(PAGE_TEXT["button"]![4])
                            .foregroundColor(Color.red)
                            .fontWeight(.bold)

                    })
                }
            }
        }
    }

    func removeFromCart(productId: String) {
        DataPost().removeFromCart(userId: storedId, productId: productId, finish: finishPost)
        func finishPost(result: Bool) {
            hasCartUpdate = result

            print(hasCartUpdate, "-")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}

/*
 struct CartItem: View {
     var cart: CartData
     @Binding var carts: [CartData]
     @Binding var isCartEmpty: Bool
    // @Binding var quantity: String = String(carts.first(where: {$0.product.id == cart.product.id})!.quantity)
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
                         if carts.isEmpty {
                             isCartEmpty = true
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
                             //  getQty(quantity: cart.quantity, opt: "-")
                           //  var item = carts.first(where: {$0.product.id == cart.product.id})
                             $quantity =  $quantity + "1"
                         }
                         .padding(.vertical, 4)
                         .frame(maxWidth: .infinity)
                         .background(Color.white)
                         .foregroundColor(Color.red)
                         .fontWeight(.bold)

                         TextField("\($quantity)", text: $quantity)
                             .accessibilityLabel("Product Quantity")
                             .fontWeight(.semibold)
                             .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
                             .multilineTextAlignment(.center)

                         Button("+") {
                             quantity =  quantity + "1"
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

     /*   func getQty(quantity: Int, opt: String) -> Void{
          qty = quantity
          if(opt == "+"){
              qty = quantity + 1
          }else if(opt == "-"){
              qty = quantity - 1
          }
      }*/
 }

  struct ExtQuantityView: View {
      var cart: CartData
      var qty: Int
      var carts: [CartData]
      var qt: Int = carts.first(where: {$0.product.id == cart.product.id})!.quantity
      var body: some View {
          HStack {
              Button("-") {
                  //   self.allProductData[i].qty = updateQty(action: "minus", count: self.allProductData[i].qty)
                //  cart.quantity - 1
              }
              .padding(.vertical, 4)
              .frame(maxWidth: .infinity)
              .background(Color.white)
              .foregroundColor(Color.red)
              .fontWeight(.bold)

              Text("\(qt)")
                  .font(.headline)
                  .fontWeight(.semibold)
                  .frame(maxWidth: .infinity, alignment: .center)

              Button("+") {
                  print(456)
              }
              .padding(.vertical, 4)
              .frame(maxWidth: .infinity)
              .background(Color.white)
              .foregroundColor(Color.blue)
              .fontWeight(.bold)
          }
          .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
      }
  }
  */
