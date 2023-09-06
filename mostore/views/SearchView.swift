//
//  SearchView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-05.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false,content: {
                VStack {
                    TextField("\(PAGE_TEXT["input"]![7])", text: $search)
                        .accessibilityLabel(PAGE_TEXT["input"]![7])
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .id("search_products")
                        .frame( maxWidth: .infinity, maxHeight: 80, alignment: .trailing)
                        
                }
                .padding(6)
                .frame(maxHeight: 80, alignment: .top)
                .background(.gray)
               
                
                Spacer()
                
               LazyVStack(content: {
                   ForEach(1...9, id: \.self) { num in
                       Text("Hello World")
                           .fontWeight(.semibold)
                           .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
                           .background(.red)
                       
                   }
               })
            })
         

            .navigationBarTitle(PAGE_TEXT["title"]![7], displayMode: .inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
