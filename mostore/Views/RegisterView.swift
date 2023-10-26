//
//  RegisterView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

// Correct with Login
struct RegisterView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    @StateObject var registerController = RegisterController()
 
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
                            Brand()
                        }

                        VStack(alignment: .center) {
                            VStack(spacing: 15, content: {
                                Text(PAGE_TEXT["title"]![1])
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .fontDesign(.rounded)
                                    .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)

                                Text(PAGE_TEXT["text"]![13])
                                    .font(.body)
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }).foregroundColor(Color.white)
                                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)

                            VStack(spacing: 30, content: {
                                VStack(spacing: 15, content: {
                                    TextFieldView(placeholder: "\(PAGE_TEXT["input"]![0])", placement: .leading, id: "register__username", value: $registerController.username).textFieldStyle(.roundedBorder)

                                    TextFieldView(placeholder: "\(PAGE_TEXT["input"]![3])", placement: .leading, id: "register__phone", value: $registerController.phone)
                                        .textFieldStyle(.roundedBorder)

                                    TextFieldView(placeholder: "\(PAGE_TEXT["input"]![1])", placement: .leading, id: "register__email", value: $registerController.emailAddress)
                                        .textFieldStyle(.roundedBorder)

                                    SecureField(PAGE_TEXT["input"]![2], text: $registerController.password)
                                        .accessibilityLabel(PAGE_TEXT["input"]![2])
                                        .id("register__password")
                                        .textFieldStyle(.roundedBorder)

                                    SecureField(PAGE_TEXT["input"]![8], text: $registerController.confirmPassword)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![8])
                                        .id("register__confirm__password")

                                })
                                VStack(spacing: 15, content: {
                                    NavigationButton(name:
                                        registerController.isLoading ?
                                            ProgressView()
                                            .tint(.white)
                                            .frame(maxWidth: .infinity) : Text("\(PAGE_TEXT["title"]![1])")
                                            .frame(maxWidth: .infinity)
                                                     , destination: AnyView(HomeView(next: true)), topPadding: 8, acColor: .white, bgColor: .blue, corner: 20, fontSize: .body, isMovable: $registerController.navigate, action: { registerController.registerUser() })

                                    VStack {
                                        Text("Already a member?")
                                            .foregroundColor(.white)
                                            .bold()
                                        NavigationLink(destination: LoginView(), label: {
                                            Text(PAGE_TEXT["title"]![0])
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

                    .alert(isPresented: $registerController.showAlert, content: getAlert)
                }
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            }.ignoresSafeArea(.keyboard, edges: .all)

                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
        }
    }

    func getAlert() -> Alert {
        if registerController.status == "warning" {
            return Alert(title: Text("\(registerController.errorMessage)"))
        } else {
            let primaryButton: Alert.Button = .cancel()
            let secondaryButton: Alert.Button = .default(Text("Proceed")) {
                registerController.navigate = true
            }
            return Alert(title: Text("Registration Successful"), message: Text("Welcome to Mattire! You can start shopping with us."), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
