//
//  MainView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cartManager: CartManager
    @StateObject var productController = ProductController()
    
 //   @StateObject var cartManager = CartManager()

    @State private var gotoDetails: Bool = false
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    init() {
    }

    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: SearchView(), label: {
                    HStack(alignment: .center, spacing: 40, content: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .fontWeight(.bold)
                            .clipped()
                            .frame(maxWidth: 40)

                        Text("\(PAGE_TEXT["input"]![7])")
                            .fontWeight(.thin)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })

                })
                .padding(8)
                .padding(.horizontal, 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 0.5)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                )
                .accentColor(Color.gray.opacity(0.7))
            }
            .padding(8)
            .padding(.horizontal, 10)
            ScrollView {
                VStack(alignment: .leading, spacing: 20, content: {
                    VStack(spacing: 20, content: {
                        VStack {
                            Text(PAGE_TEXT["text"]![16])
                                .font(.title3)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(productController.recommendedProducts) { product in
                                        VStack(content: {
                                            ProductLink(item: product, size: 150, shape: Circle())
                                        })
                                    }

                                })
                            })
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![9])
                                .font(.title3)
                                .fontWeight(.bold)

                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(productController.bestProducts) { product in
                                        ProductLink(item: product, size: 350, shape: RoundedRectangle(cornerRadius: 8))
                                    }

                                })

                            })
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![10])
                                .font(.title3)
                                .fontWeight(.bold)
                            LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                                ForEach(productController.dealProducts) { product in
                                    HStack(spacing: 30, content: {
                                        ProductLink(item: product, size: 150, shape: RoundedRectangle(cornerRadius: 8))
                                    })
                                }
                            })
                        }
                        .padding()

                    })
                    .padding()

                })
            }

            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .background(
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
            )

            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TitleToolBarItem(title: PAGE_TEXT["title"]![6])
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination:
                        CartView(), label: {
                            CartButton(numberOfProduct: cartManager.singleProductOccurence.count)
                        })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gear")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .fontWeight(.semibold)
                            .frame(alignment: .trailing)
                            .clipped()

                    })
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
            .environmentObject(CartManager())
    }
}
