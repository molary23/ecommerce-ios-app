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
    @State private var isAlertActive: Bool = false
    @State private var gotoCart: Bool = false
    @State private var gotoShop: Bool = false
    init() {
        // UINavigationBar.appearance().backgroundColor = UIColor.blue
    }

    var body: some View {
        let name: String? = product.product["name"] as? String ?? ""
        let image: String = product.product["image"] as? String ?? ""
        let description: String = product.product["description"] as? String ?? ""
        let price: Double = product.product["price"] as? Double ?? 0.0
        let rating: Double = product.product["rating"] as? Double ?? 4.0
        let images = image.components(separatedBy: "|")
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(spacing: nil, content: {
                                ForEach(images, id: \.self) { image in
                                    ZStack {
                                        ExtAsyncImage(imageURL: image, size: 500, shape: Rectangle())
                                    }
                                }
                            })

                        })

                        VStack(spacing: 10, content: {
                            Text("\(name!.capitalized)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .greatestFiniteMagnitude)

                            HStack(spacing: 4) {
                                Image(systemName: rating >= 4 ? "star.fill" : "star")
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .font(.title3)
                                    .frame(alignment: .center)
                                    .clipped()

                                Text("\(rating, specifier: "%.1f")")
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                            }
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                            Text("$\(price, specifier: "%.2f")")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                            VStack(spacing: 10, content: {
                                Text("Description")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                                LabelAlignment(text: "\(description)", textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 20, size: 20.0)

                            })
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                        })
                        .padding()
                    }
                }
                .overlay(
                    FloatingButton(action: { addToCart() }, icon: "cart.badge.plus", fg: Color.white, bg: Color.blue, label: "Add to cart")
                        .alert(isPresented: $isAlertActive, content: getAlert)
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
        DataPost().addToCart(userId: "64ed3a3efc29f826a41df4c2", productId: product.product["id"] as! String, finish: finishPost)

        func finishPost(result: Bool) {
            isAlertActive = result
        }

       
    }

    func getAlert() -> Alert {
        return Alert(title: Text("Item added to cart"))
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(Product())
    }
}
