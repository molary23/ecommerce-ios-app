//
//  MainView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct MainView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10, alignment: nil),
        // GridItem(.flexible(), spacing: 10, alignment: nil),
    ]
    @State private var search: String = ""
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
       // UINavigationBar.appearance().backgroundColor = UIColor.green
    }

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
                    .frame(width: .infinity, height: 40)
                    .background(Color.white)

                    VStack(spacing: 20, content: {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(spacing: 20, content: {
                                ForEach(1 ... 10, id: \.self) { _ in
                                    VStack(content: {
                                        Circle()
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color.yellow)
                                        Text("Hello World")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
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
                                        VStack(content: {
                                            RoundedRectangle(cornerRadius: 8)
                                                .frame(width: 250, height: 300)
                                                .foregroundColor(Color.brown)
                                            Text("Hello World")
                                                .font(.headline)
                                                .fontWeight(.semibold)
                                            Text("Hello World")
                                                .font(.subheadline)

                                        })
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
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 150, height: 200)
                                            .foregroundColor(Color.cyan)

                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 150, height: 200)
                                            .foregroundColor(Color.cyan)
                                    })
                                }
                            })
                        }
                        .padding()

                    })

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
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
