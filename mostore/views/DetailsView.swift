//
//  DetailsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    let icon: String
    let fg: Color
    let bg: Color
    let label: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .foregroundColor(fg)
                }
                .frame(width: 60, height: 60)
                .accessibilityLabel(label)
                .background(bg)
                .cornerRadius(30)
                .shadow(radius: 10)
                .offset(x: -25, y: 10)
            }
        }
    }
}

struct DetailsView: View {
    init() {
       // UINavigationBar.appearance().backgroundColor = UIColor.blue
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ZStack {
                            Image("shopping")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxHeight: 500)
                                .clipped()
                        }

                        VStack(spacing: 10, content: {
                            Text("Tote Bag")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .greatestFiniteMagnitude)

                            Text("$50.77")
                                .font(.title3)
                                .fontWeight(.bold)
                                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                            VStack(spacing: 10, content: {
                                Text("Description")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                                LabelAlignment(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque blandit gravida ipsum ac commodo. Cras ultricies lectus vitae purus tempus, sit amet laoreet urna eleifend. Pellentesque molestie convallis nulla vel mattis. Aenean bibendum sem a metus commodo tempus. Integer quis neque sem. Nullam a aliquet augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam convallis pellentesque dui nec accumsan. Aliquam et placerat augue. Curabitur at dui enim. Curabitur non ante et urna tristique pellentesque quis vel tortor. Nunc varius mi eu ultricies mollis. Duis vel elit faucibus, molestie felis vitae, imperdiet eros. Vestibulum a tellus id nibh laoreet interdum.", textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 20, size: 20.0)

                            })
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                        })
                        .padding()
                    }
                }
                .overlay(
                    FloatingButton(action: { print("Add to Cart") }, icon: "cart.badge.plus", fg: Color.white, bg: Color.blue, label: "Add to cart")
                )
            }
            .ignoresSafeArea(edges: .top)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    NavigationLink(destination: MainView(), label: {
                        Image(systemName: "multiply.circle")
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

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
