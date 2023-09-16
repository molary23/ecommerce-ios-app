//
//  BookView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-27.
//

import SwiftUI

struct BookView: View {
    @State var books = [Book]()
    @State var carts: [CartData] = []
    @State private var atoken = ""
    var body: some View {
        /*    Text("Hello, world!")
            .padding()
         .onAppear() {
               Api().loadData { (books) in
                    self.books = books
                }
          }.navigationTitle("Book List")*/

        ForEach(carts) { cart in
            Text("\(cart.quantity)")
        }
        .onAppear {
            CartApi().loadCartData(userId: "64f17793033bd22637553a57") { carts in

                self.carts = carts
            }
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}

/*      HStack(spacing: 8, content: {
 ExtAsyncImage(imageURL: item.product.image.components(separatedBy: "|")[0], size: 100, shape: RoundedRectangle(cornerRadius: 8))

 VStack {
 HStack(spacing: 8, content: {
 Text("\(item.product.name)")
 .font(.body)
 .fontWeight(.bold)

 .frame(maxWidth: .infinity, alignment: .leading)
 .multilineTextAlignment(.leading)
 .fixedSize(horizontal: false, vertical: true)
 Button(action: {
 carts = carts.filter({ $0.product.id != item.product.id })
 if carts.isEmpty {
 isCartEmpty = true
 }

 }) {
 Image(systemName: "trash")
 .renderingMode(.original)
 .aspectRatio(contentMode: .fit)
 .font(.body)
 .foregroundColor(Color.orange)
 .frame(alignment: .trailing)
 .clipped()
 }
 }).frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .topLeading)
 HStack {
 Image(systemName: item.product.rating > 4 ? "star.fill" : "star")
 .renderingMode(.original)
 .aspectRatio(contentMode: .fit)
 .font(.body)
 .frame(alignment: .leading)
 .clipped()

 Text("\(item.product.rating, specifier: "%.1f")")
 .font(.headline)
 .fontWeight(.semibold)
 .foregroundColor(Color.indigo)
 .frame(maxWidth: .infinity, alignment: .leading)
 }
 .frame(maxHeight: .greatestFiniteMagnitude, alignment: .leading)

 HStack {
 HStack {
 Button("-") {
 updateCart(opt: "-", orderId: "64f2a35e89ece621daa0a330", productId: item.product.id)
 }
 .padding(.vertical, 4)
 .frame(maxWidth: .infinity)
 .background(Color.white)
 .foregroundColor(Color.red)
 .fontWeight(.bold)

 TextField("\(item.quantity)", text: $quantity)
 .accessibilityLabel("Product Quantity")
 .fontWeight(.semibold)
 .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
 .multilineTextAlignment(.center)
 .id(item.product.name)
 .tag(carts.firstIndex(where: { $0.product.id == item.product.id }))

 Button("+") {
 updateCart(opt: "+", orderId: "64f2a35e89ece621daa0a330", productId: item.product.id)
 }
 .padding(.vertical, 4)
 .frame(maxWidth: .infinity)
 .background(Color.white)
 .foregroundColor(Color.blue)
 .fontWeight(.bold)
 }
 .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

 Text("$\(item.product.price, specifier: "%.2f")")
 .font(.body)
 .fontWeight(.bold)
 .frame(maxWidth: .greatestFiniteMagnitude, alignment: .trailing)
 }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottomLeading)
 }
 .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)

 })
 .padding(8)
 .background(Color("off-white"))
 .cornerRadius(8)
 .frame(maxWidth: .infinity,maxHeight: 200)
 .background(.yellow)*/
