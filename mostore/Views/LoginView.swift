//
//  ContentView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    @StateObject var loginController = LoginController()
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
                            Brand()
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
                                    TextFieldView(placeholder: "\(PAGE_TEXT["input"]![0])/\(PAGE_TEXT["input"]![1])", placement: .leading, id: "login__email", value: $loginController.username)
                                        .textFieldStyle(.roundedBorder)
                                    SecureField(PAGE_TEXT["input"]![2], text: $loginController.password)
                                        .accessibilityLabel(PAGE_TEXT["input"]![2])
                                        .id("login__password")
                                        .textFieldStyle(.roundedBorder)

                                })
                                VStack(spacing: 15, content: {
                                    NavigationButton(name:
                                        loginController.isLoading ?
                                            ProgressView()
                                            .tint(.white)
                                            .frame(maxWidth: .infinity) : Text("\(PAGE_TEXT["title"]![0])")
                                            .frame(maxWidth: .infinity)
                                                     , destination: AnyView(HomeView(next: true)), topPadding: 8, acColor: .white, bgColor: .blue, corner: 20, fontSize: .body, isMovable: $loginController.isSignedIn, action: { loginController.login() })

                                    VStack {
                                        Text("Are you new here?")
                                            .bold()
                                            .foregroundColor(.white)

                                        NavigationLink(destination: RegisterView(), label: {
                                            Text(PAGE_TEXT["title"]![1])
                                                .frame(maxWidth: .infinity)
                                                .accentColor(.white)
                                                .fontWeight(.bold)
                                        })
                                    }

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
                .alert(isPresented: $loginController.showAlert, content: getAlert)
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            }.ignoresSafeArea(.keyboard, edges: .all)

                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
    }

    func getAlert() -> Alert {
        return Alert(title: Text("\(loginController.errorMessage)"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
