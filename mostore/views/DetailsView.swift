//
//  DetailsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var product: Product
    @StateObject private var cart = Cart()
    @State private var isActive: Bool = false
    @State private var gotoCart: Bool = false
    @State private var gotoShop: Bool = false
    init() {
        // UINavigationBar.appearance().backgroundColor = UIColor.blue
    }

    var body: some View {
        let name: String = product.product["name"] ?? ""
        let image: String = product.product["image"] ?? "shopping"
        let desc: String = product.product["desc"] ?? ""
        let price: String = product.product["price"] ?? ""
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ZStack {
                            Image("\(image)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 500)
                                .clipped()
                        }

                        VStack(spacing: 10, content: {
                            Text("\(name.capitalized)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .greatestFiniteMagnitude)

                            Text("$\(price)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                            VStack(spacing: 10, content: {
                                Text("Description")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                                LabelAlignment(text: "\(desc)", textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 20, size: 20.0)

                            })
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                        })
                        .padding()
                    }
                }
                .overlay(
                    FloatingButton(action: { addToCart() }, icon: "cart.badge.plus", fg: Color.white, bg: Color.blue, label: "Add to cart")
                        .alert(isPresented: $isActive, content: getAlert)
                )

                if gotoCart {
                    NavigationLink(destination: CartView(), label: { EmptyView() })
                }

                if gotoShop {
                    NavigationLink(destination: MainView(), label: { EmptyView() })
                }
            }
            .ignoresSafeArea(edges: .top)
        }
    }

    func addToCart() {
        //  cart.cart.append(product)
        isActive = true
    }

    func getAlert() -> Alert {
        return Alert(title: Text("Item added to cart"))
    }

    /*  func getActionSheet() -> ActionSheet {
         let toCart: ActionSheet.Button = .default(Text("Go to Cart")) {
         }

         let toShop: ActionSheet.Button = .default(Text("Continue Shopping")) {
         }

         let toCancel: ActionSheet.Button = .cancel({ isActive = false })

         return ActionSheet(title: Text("What Next?"), message: Text(""), buttons: [toCart, toShop, toCancel])
     }*/
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(Product())
    }
}
