//
//  HomeView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeController = HomeController()
    //  @StateObject var cartManager = CartManager()
    @EnvironmentObject var cartManager: CartManager

    var next: Bool

    let storedId: String = preferences.string(forKey: idKey) ?? ""

    var body: some View {
        if !storedId.isEmpty || next {
            ProductView()
                //  .environmentObject(CartManager())
                .onAppear(perform: {
                    cartManager.getCartItems()
                })

        } else {
            LoginView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(next: false)
            .environmentObject(CartManager())
    }
}
