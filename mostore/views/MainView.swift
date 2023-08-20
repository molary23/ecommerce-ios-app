//
//  MainView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, content: {
                HStack(alignment: .center, content: {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.body)
                        .foregroundColor(Color.orange)
                        .clipped()

                    TextField("Search Products", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(.plain)
                        .background(Color.white)

                })
                .padding()
                .padding(.horizontal, 40)
                .frame(width: .infinity, height: 40)
                .background(Color.cyan)

                VStack(spacing: 20, content: {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 20, content: {
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

                    Text("Best Sellers")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 40, content: {
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

                    Text("Deals")
                        .font(.headline)
                    VStack(spacing: 40, content: {
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

                })

            })
        }
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(Color.white)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
