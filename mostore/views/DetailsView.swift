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
      //  let id: String = product.product["id"] as? String ?? "adeola"
        let name: String = product.product["name"] as? String ?? "adeola"
        let image: String = /*product.product["image"] as? String ??*/  "https://images-na.ssl-images-amazon.com/images/I/51j3fPQTQkL.jpg|https://images-na.ssl-images-amazon.com/images/I/31hKM3cSoSL.jpg|https://images-na.ssl-images-amazon.com/images/I/51WlHdwghfL.jpg|https://images-na.ssl-images-amazon.com/images/I/51FsyLRBzwL.jpg|https://images-na.ssl-images-amazon.com/images/G/01/x-locale/common/transparent-pixel.jpg"
        let description: String = product.product["description"] as? String ?? "Welcome to normal description"
        let price: Double = product.product["price"] as? Double ?? 0.0
        let images = image.components(separatedBy: "|")
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false, content: {
                            LazyHStack(spacing: nil, content: {
                                ForEach(images, id: \.self) { image in
                                    ZStack {
                                        AsyncImage(url: URL(string: image)!, placeholder: {
                                            ProgressView()
                                        })
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 500)
                                        .clipped()
                                    }
                                }
                            })

                        })

                        VStack(spacing: 10, content: {
                            Text("\(name.capitalized)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .greatestFiniteMagnitude)

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
        DataPost().postRequest(userId: "64ed3a3efc29f826a41df4c2", productId: /*product.product["id"] as! String*/ "64ed53ecf34e3ac82344a30e", finish: finishPost)
        
        func finishPost(result: Int){
            print("Go-->\(result)")
        }
      
        isAlertActive = true
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
