//
//  CartButton.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-18.
//

import SwiftUI

struct CartButton: View {
    var numberOfProduct: Int
    var body: some View {
        ZStack(alignment: .topTrailing){
            Image(systemName: "cart")
                .padding(.top, 5)
            
            if(numberOfProduct > 0){
                Text("\(numberOfProduct)")
                    .font(.caption2)
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(Color.red)
                    .cornerRadius(50)
            }
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(numberOfProduct: 1)
    }
}
