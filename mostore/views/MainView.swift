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
    @State private var gotoDetails: Bool = false
    @State private var search: String = ""
    let imageURL: String = "https://placekitten.com/200/200"
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
    ]

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        // UINavigationBar.appearance().backgroundColor = UIColor.green
    }

    let aspect = 1.5

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20, content: {
                    HStack(alignment: .center, spacing: 20, content: {
                        Image(systemName: "magnifyingglass")
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundColor(Color.orange)
                            .clipped()
                            .frame(maxWidth: 40)

                        TextField(PAGE_TEXT["input"]![7], text: $search)
                            .textFieldStyle(.plain)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, maxHeight: 50)

                    })
                    .padding(8)
                    .padding(.horizontal, 40)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.white)

                    VStack(spacing: 20, content: {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(spacing: 20, content: {
                                ForEach(1 ... 10, id: \.self) { _ in
                                    VStack(content: {
                                        Button(action: { navigateToDetails() }, label: {
                                            VStack {
                                                AsyncImage(url: URL(string: imageURL)!, placeholder: {
                                                    ProgressView()

                                                })
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 100, height: 100)
                                                .clipped()
                                                .cornerRadius(100)

                                                Text("Hello World \(storedUsername)")
                                                    .font(.subheadline)
                                                    .fontWeight(.semibold)
                                            }
                                        })
                                        .navigationDestination(isPresented: $gotoDetails) {
                                            DetailsView()
                                        }

                                    })
                                }

                            })
                        })

                        VStack {
                            Text(PAGE_TEXT["text"]![9])
                                .font(.headline)
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHGrid(rows: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                                    ForEach(1 ... 9, id: \.self) { _ in

                                        Button(action: { navigateToDetails() }, label: {
                                            VStack {
                                                AsyncImage(url: URL(string: imageURL)!, placeholder: {
                                                    ProgressView()
                                                })
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 300)
                                                .clipped()
                                                .cornerRadius(8)
                                                Text("Hello World")
                                                    .font(.headline)
                                                    .fontWeight(.semibold)
                                                Text("Hello World")
                                                    .font(.subheadline)
                                            }
                                        })
                                        .navigationDestination(isPresented: $gotoDetails) {
                                            DetailsView()
                                        }
                                    }

                                })

                            })
                        }

                        VStack {
                            Text(PAGE_TEXT["text"]![10])
                                .font(.headline)
                            LazyVGrid(columns: columns, alignment: .center, spacing: 20, pinnedViews: [], content: {
                                ForEach(1 ... 10, id: \.self) { _ in
                                    HStack(spacing: 30, content: {
                                        Button(action: { navigateToDetails() }, label: {
                                            VStack {
                                                AsyncImage(url: URL(string: imageURL)!, placeholder: {
                                                    ProgressView()
                                                })

                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150)
                                                .clipped()
                                                .cornerRadius(8)
                                            }
                                        })
                                        .navigationDestination(isPresented: $gotoDetails) {
                                            DetailsView()
                                        }

                                        Button(action: { navigateToDetails() }, label: {
                                            VStack {
                                                AsyncImage(url: URL(string: imageURL)!, placeholder: {
                                                    ProgressView()
                                                })
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150)
                                                .clipped()
                                                .cornerRadius(8)
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

                    })
                    .padding()

                })
            }

            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .background(
                Color.green
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

    func navigateToDetails() {
        product.product["id"] = "1234"
        product.product["name"] = "A product"
        product.product["image"] = "shopping"
        product.product["desc"] = "A product is a product"
        product.product["price"] = "114"
        gotoDetails = true
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
