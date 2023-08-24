//
//  ContentView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

func handleLogin(username: String, password: String) {
    print(username, password)
}

struct LoginView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?

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
                        //  .rotationEffect(.degrees(90))
                        .ignoresSafeArea()

                    VStack(alignment: .center, content: {
                        Spacer()
                        Spacer()

                        if self.verticalSizeClass != .compact {
                            Spacer()
                            Spacer()
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
                                    TextField("\(PAGE_TEXT["input"]![0])/\(PAGE_TEXT["input"]![1])", text: $username)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![0])
                                        .id("login__email")

                                    SecureField(PAGE_TEXT["input"]![2], text: $password)
                                        .accessibilityLabel(PAGE_TEXT["input"]![2])
                                        .id("login__password")
                                        .textFieldStyle(.roundedBorder)

                                })
                                VStack(spacing: 15, content: {
                                    Button(PAGE_TEXT["title"]![0]) {
                                        handleLogin(username: self.username, password: self.password)
                                    }
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
