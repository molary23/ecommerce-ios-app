//
//  BookView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-27.
//

import SwiftUI

struct BookView: View {
    @State var books = [Book]()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                Api().loadData { (books) in
                    self.books = books
                }
            }.navigationTitle("Book List")
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
