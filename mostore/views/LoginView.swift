//
//  ContentView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
    
    @State private var emailAddress: String = ""
    @State private var password: String = ""
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(self.verticalSizeClass != .compact ? "shopping": "shopping-land")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .clipped()
                   //  .rotationEffect(.degrees(90))
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, content: {
                    Spacer()
                    Spacer()
                    
                       if(self.verticalSizeClass != .compact) {
                            Spacer()
                            Spacer()
                            HStack {
                                Circle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color.red)
                                Text(STRING_TUPLE.8)
                                    .font(.largeTitle)
                                    .fontWeight(.black)
                                    .foregroundColor(Color.white)
                                    .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 2)
                            }
                            .frame(maxWidth: .infinity)
                        
                        }

                    VStack (alignment: .center){
                        Text(STRING_TUPLE.2)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .fontDesign(.rounded)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
                            .padding(.bottom, 20.0)
                            .shadow(color: Color.black.opacity(0.8), radius: 1, x: 1, y: 1)

                        VStack(spacing: 30, content: {
                            VStack(spacing: 15, content: {
                                TextField(STRING_TUPLE.0, text: $emailAddress)
                                    .textFieldStyle(.roundedBorder)
                                    .accessibilityLabel(STRING_TUPLE.0)
                                    .id("login__email")

                                SecureField(STRING_TUPLE.1, text: $password)
                                    .accessibilityLabel(STRING_TUPLE.1)
                                    .id("login__password")
                                    .textFieldStyle(.roundedBorder)

                            })
                            VStack(spacing: 15, content: {
                                Button(STRING_TUPLE.2) {}
                                    .padding(.vertical, 8.0)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(20)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)

                                Button(STRING_TUPLE.3) {}
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
                            .cornerRadius(8)
                            .shadow(color: Color.black, radius: 5, x: 1, y: 1)
                    )

                    Spacer()
                })
                .padding()
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
                .background(Color.black.opacity(0.5))
                
            }
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
