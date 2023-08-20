//
//  RegisterView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

var registerTuple = (
    "Email Address",
    "Password",
    "Login",
    "Register",
    "Phone Number",
    "Username",
    "All fields are compulsory"
)

struct RegisterView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("shopping")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, content: {
                    HStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.red)
                        Text("Mo Store")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 2)
                    }
                    .frame(maxWidth: .infinity)

                    VStack(spacing: 20, content: {
                        VStack(spacing: 15, content: {
                            Text(registerTuple.3)
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .fontDesign(.rounded)
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)

                            Text(registerTuple.6)
                                .font(.body)
                                .italic()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)
                        })

                        VStack(spacing: 30, content: {
                            VStack(spacing: 15, content: {
                                TextField(registerTuple.5, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(registerTuple.5)
                                    .id("login__username")

                                TextField(registerTuple.4, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(registerTuple.4)
                                    .id("login__phone")

                                TextField(registerTuple.0, text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(registerTuple.0)
                                    .id("login__email")

                                TextField("*********", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(registerTuple.1)
                                    .id("login__password")
                                TextField("*********", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/ .constant("")/*@END_MENU_TOKEN@*/)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(registerTuple.1)
                                    .id("login__confirm__password")
                            })
                            VStack(spacing: 15, content: {
                                Button(registerTuple.3) {}
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                                Button(registerTuple.2) {}
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.blue)
                                    .fontWeight(.bold)
                            })

                        })
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .compositingGroup()
                        .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)
                    })
                    .padding()
                    .padding(.vertical, 20)
                    .frame(width: .infinity, height: 480)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color(#colorLiteral(red: 0.9150597453, green: 0.9150597453, blue: 0.9150597453, alpha: 0.55)))
                            .shadow(color: Color.black, radius: 10, x: 10, y: 15)
                    )

                    Rectangle()
                        .frame(height: 80)
                        .foregroundColor(Color.clear)
                })
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Color.black.opacity(0.5))
            }
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
