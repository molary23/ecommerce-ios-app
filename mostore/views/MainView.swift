//
//  MainView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var user: User
    @StateObject private var product = Product()

    @State var bestProducts = [ProductData]()
    @State var recProducts = [ProductData]()
    @State var dealProducts = [ProductData]()
    @State private var gotoDetails: Bool = false
    @State private var toSearch: Bool = false
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        // UINavigationBar.appearance().backgroundColor = UIColor.green
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20, content: {
                    Button(action: {}, label: {
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
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .accentColor(Color.gray.opacity(0.7))
                    .background(Color.white)

                    VStack(spacing: 20, content: {
                        VStack {
                            Text(PAGE_TEXT["text"]![16])
                                .font(.title3)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(recProducts) { product in
                                        VStack(content: {
                                            Button(action: { navigateToDetails(content: product) }, label: {
                                                VStack {
                                                    ExtAsyncImage(imageURL: product.image.components(separatedBy: "|")[0], size: 150, shape: Circle())

                                                    Text("\(product.name)")
                                                        .font(.caption)
                                                        .multilineTextAlignment(.center)
                                                    Spacer()

                                                    Text("$\(product.price, specifier: "%.2f")")
                                                        .font(.body)
                                                        .fontWeight(.bold)
                                                }
                                                .frame(width: 150)
                                            })
                                            .navigationDestination(isPresented: $gotoDetails) {
                                                DetailsView()
                                            }

                                        })
                                    }

                                })
                            })
                        }.onAppear {
                            Api().loadData(page: 1, limit: 5) { products in
                                self.recProducts = products
                            }
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![9])
                                .font(.title3)
                                .fontWeight(.bold)

                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: 20, content: {
                                    ForEach(bestProducts) { product in

                                        Button(action: { navigateToDetails(content: product) }, label: {
                                            VStack {
                                                ExtAsyncImage(imageURL: product.image.components(separatedBy: "|")[0], size: 500, shape: RoundedRectangle(cornerRadius: 8))

                                                Text("\(product.name)")
                                                    .font(.headline)
                                                    .fontWeight(.bold)

                                                Text("$\(product.price, specifier: "%.2f")")
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                            }
                                        })
                                        .navigationDestination(isPresented: $gotoDetails) {
                                            DetailsView()
                                        }
                                    }

                                })

                            })
                        }
                        .onAppear {
                            Api().loadData(page: 0, limit: 5) { products in
                                self.bestProducts = products
                            }
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![10])
                                .font(.title3)
                                .fontWeight(.bold)
                            LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                                ForEach(dealProducts) { product in
                                    HStack(spacing: 30, content: {
                                        Button(action: { navigateToDetails(content: product) }, label: {
                                            VStack {
                                                ExtAsyncImage(imageURL: product.image.components(separatedBy: "|")[0], size: 150, shape: RoundedRectangle(cornerRadius: 8))
                                            }
                                        })
                                        .navigationDestination(isPresented: $gotoDetails) {
                                            DetailsView()
                                        }

                                    })
                                }
                            })
                        }
                        .padding()
                        .onAppear {
                            Api().loadData(page: 2, limit: 10) { products in
                                self.dealProducts = products
                            }
                        }

                    })
                    .padding()

                })
            }

            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .background(
                Color.gray.opacity(0.1)
                    .ignoresSafeArea()
            )

            .navigationBarTitle(PAGE_TEXT["title"]![6], displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CartView(), label: {
                        Image(systemName: "cart")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .foregroundColor(Color.orange)
                            .frame(alignment: .trailing)
                            .clipped()

                    })
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(), label: {
                        Image(systemName: "gear")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .foregroundColor(Color.orange)
                            .frame(alignment: .trailing)
                            .clipped()

                    })
                }
            }
        }
        .environmentObject(product)
    }

    func navigateToDetails(content: ProductData) {
        product.product["id"] = content.id
        product.product["name"] = content.name
        product.product["image"] = content.image
        product.product["description"] = content.description
        product.product["price"] = content.price
        product.product["rating"] = content.rating
        gotoDetails = true
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        //   .environmentObject(product)
    }
}
