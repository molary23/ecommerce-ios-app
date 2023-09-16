//
//  HomeView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-09-15.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        if storedEmail.isEmpty {
            LoginView()
        } else {
            MainView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
