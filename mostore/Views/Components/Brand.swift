//
//  Brand.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct Brand: View {
    var body: some View {
        HStack {
            Image("app-icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)
               
        }
      //  .padding(.horizontal, 20)
        .frame(maxWidth: 200, alignment: .center)
    }
}

struct Brand_Previews: PreviewProvider {
    static var previews: some View {
        Brand()
    }
}
