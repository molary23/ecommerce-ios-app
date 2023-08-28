//
//  ContentView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    @StateObject private var user = User()
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var goHome: Bool = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image(self.verticalSizeClass != .compact ? "shopping" : "shopping-land")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .clipped()
                        .ignoresSafeArea()

                    VStack(alignment: .center, content: {
                        Spacer()
                        Spacer()

                        if self.verticalSizeClass != .compact {
                            Spacer()
                            Spacer()
                            ExtBrand()
                        }

                        VStack(alignment: .center) {
                            Text(PAGE_TEXT["title"]![0])
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .fontDesign(.rounded)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                                .padding(.bottom, 20.0)
                                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)

                            VStack(spacing: 30, content: {
                                VStack(spacing: 15, content: {
                                    ExtTextFieldView(placeholder: "\(PAGE_TEXT["input"]![0])/\(PAGE_TEXT["input"]![1])", placement: .leading, id: "login__email", value: $username).textFieldStyle(.roundedBorder)

                                    SecureField(PAGE_TEXT["input"]![2], text: $password)
                                        .accessibilityLabel(PAGE_TEXT["input"]![2])
                                        .id("login__password")
                                        .textFieldStyle(.roundedBorder)

                                })
                                VStack(spacing: 15, content: {
                                    ExtNavButtonView(name: "\(PAGE_TEXT["title"]![0])", isMovable: $goHome, isActive: handleLogin(username: self.username, password: self.password), destination: AnyView(MainView()), topPadding: 8.0, acColor: .white, bgColor: .blue, corner: 25, size: .body)

                                    NavigationLink(destination: RegisterView(), label: {
                                        Text(PAGE_TEXT["title"]![1])
                                            .padding(.vertical, 8.0)
                                            .frame(maxWidth: .infinity)
                                            .background(Color.white)
                                            .cornerRadius(20)
                                            .foregroundColor(Color.blue)
                                            .fontWeight(.bold)
                                    })

                                   
                                })

                            })
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .compositingGroup()
                            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)
                        }
                        .padding()
                        .padding(.vertical, 20)
                        .frame(
                            maxWidth: self.verticalSizeClass == .compact ? 500
                                : .greatestFiniteMagnitude,
                            minHeight: 300
                        )
                        .background(
                            Color(#colorLiteral(red: 0.9150597453, green: 0.9150597453, blue: 0.9150597453, alpha: 0.55))
                        )
                        .cornerRadius(8)
                        .shadow(color: Color.black, radius: 5, x: 1, y: 2)

                        Spacer()
                    })
                    .padding()
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                    .background(Color.black.opacity(0.5))
                }
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            }.ignoresSafeArea(.keyboard, edges: .all)

                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
        .environmentObject(user)
    }

    func handleLogin(username: String, password: String) -> Bool {
        preferences.set(username, forKey: usernameKey)
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
