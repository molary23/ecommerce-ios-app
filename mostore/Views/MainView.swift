//
//  ProductView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-16.
//

import SwiftUI

struct MainView: View {
    @StateObject var mainController = MainController()
    @StateObject var productController = ProductController()
    var body: some View {
        /* NavigationStack{
             if(!productController.bestDetails){
                 ProductView()
             }else{
                 DetailsView(productDetails: productController.product)
             }
         }*/
        Text("Hello World")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
