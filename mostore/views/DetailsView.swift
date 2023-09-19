//
//  DetailsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var product: Product
    @EnvironmentObject var cartManager : CartManager
    
    @StateObject var detailsController = DetailsController()
    
    private let name: String
    private let description: String
    private let image: String
    private let price: Double
    private let rating: Double
    private let id: String
    private let productDetails: ProductModel
    init(productDetails: ProductModel) {
        self.productDetails = productDetails
        id = productDetails.id
        name = productDetails.name
        description = productDetails.description
        image = productDetails.image
        price = productDetails.price
        rating = productDetails.rating
        // UINavigationBar.appearance().backgroundColor = UIColor.blue
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        if !image.isEmpty {
                            let images = image.components(separatedBy: "|")
                            ScrollView(.horizontal, showsIndicators: false, content: {
                                LazyHStack(spacing: nil, content: {
                                    ForEach(images, id: \.self) { image in
                                        ZStack {
                                            DataImage(imageURL: image, size: 500, shape: Rectangle())
                                        }
                                    }
                                })

                            })
                        }

                        VStack(spacing: 10, content: {
                            Text("\(name)")
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
                    FloatingButton(icon: "cart.badge.plus", fg: Color.white, bg: Color.blue, label: "Add to cart") {
                        cartManager.addToCart(product: productDetails)
                        detailsController.addToCart(id: id)
                       
                    }
                )
                .alert(isPresented: $detailsController.showAlert, content: getAlert)
              
            }
            .ignoresSafeArea(edges: .top)
        }
    }

   

    func getAlert() -> Alert {
        return Alert(title: Text("Item added to cart"))
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            productDetails: .init(id: "", name: "", description: "", price: 0.0, image: "", rating: 0.0, createdAt: "", updatedAt: "")
        )
        .environmentObject(CartManager())
    }
}
