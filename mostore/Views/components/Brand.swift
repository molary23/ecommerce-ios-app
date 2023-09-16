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
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.red)
            Text(PAGE_TEXT["text"]![0])
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.white)
                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 2)
        }
        .frame(maxWidth: .infinity)
    }
}

struct Brand_Previews: PreviewProvider {
    static var previews: some View {
        Brand()
    }
}
