//
//  AsyncImage.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct DataImage: View {
    var imageURL: String
    var size: CGFloat
    var shape: any Shape
    var body: some View {
        
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .frame(width: size, height: size)
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fit)
                    .transition(.scale(scale: 0.1, anchor: .center))
                    .frame(maxWidth: size, maxHeight: size)
                
            case .failure:
                Image(systemName: "photo")
                    .frame(width: size, height: size)
            @unknown default:
                ProgressView()
                    .frame(width: size, height: size)
            }
        }
        .frame(maxWidth: size, maxHeight: size)
        .background(Color("off-white"))
        .clipShape(AnyShape(shape))
    }
}

struct DataImage_Previews: PreviewProvider {
    static var previews: some View {
        DataImage(imageURL: "https://dummyimage.com/640x360/fff/aaa", size: 150, shape: Circle())
    }
}
