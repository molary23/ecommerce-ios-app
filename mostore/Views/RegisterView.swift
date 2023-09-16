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
    @EnvironmentObject var user: User

    @State private var response: Any = false

    @State private var emailAddress: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var phone: String = ""
    @State private var username: String = ""

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
                                    ExtTextFieldView(placeholder: PAGE_TEXT["input"]![0], placement: .leading, id: "register__username", value: $username).textFieldStyle(.roundedBorder)

                                    TextField(PAGE_TEXT["input"]![0], text: $username)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![0])
                                        .id("register__username")

                                    TextField(PAGE_TEXT["input"]![3], text: $phone)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![3])
                                        .id("register__phone")

                                    TextField(PAGE_TEXT["input"]![1], text: $emailAddress)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![0])
                                        .id("register__email")

                                    SecureField(PAGE_TEXT["input"]![2], text: $password)
                                        .accessibilityLabel(PAGE_TEXT["input"]![2])
                                        .id("register__password")
                                        .textFieldStyle(.roundedBorder)

                                    TextField(PAGE_TEXT["input"]![8], text: $confirmPassword)
                                        .textFieldStyle(.roundedBorder)
                                        .accessibilityLabel(PAGE_TEXT["input"]![8])
                                        .id("register__confirm__password")

                                })
                                VStack(spacing: 15, content: {
                                    ExtButtonView(name: "\(PAGE_TEXT["title"]![1])", response: $response, onRequestDone: registerUser(), topPadding: 8.0, acColor: .white, bgColor: .blue, corner: 25, size: .body)

                                    NavigationLink(destination: LoginView(), label: {
                                        Text(PAGE_TEXT["title"]![0])
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

    func registerUser() -> Bool {
        return true
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(User())
    }
}
