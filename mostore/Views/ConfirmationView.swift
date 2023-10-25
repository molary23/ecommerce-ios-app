//
//  ConfirmationView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct ConfirmationView: View {
    @State private var goHome: Bool = false
    init() {
    }

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text(PAGE_TEXT["text"]![14])
                        .font(.largeTitle)
                }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)
                    .foregroundColor(.white)
                    .bold()

                VStack(alignment: .center, spacing: 20, content: {
                    Image(systemName: "hand.thumbsup")
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .font(.custom("checkmark", fixedSize: 100))
                        .foregroundColor(Color.orange)
                        .clipped()

                    Spacer()

                    VStack(spacing: 8) {
                        Text(PAGE_TEXT["text"]![1])
                            .font(.title2)
                            .bold()
                            .frame(maxWidth: .infinity)

                        Text(PAGE_TEXT["text"]![2])
                            .font(.title3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundColor(.gray)

                    Spacer()

                    Button(action: {
                        goHome = true
                    }, label: {
                        Text("\(PAGE_TEXT["button"]![1])")
                            .frame(maxWidth: .infinity)
                    })
                    .padding(.vertical, 15)
                    .accentColor(.white)
                    .background(.blue)
                    .cornerRadius(40)
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .greatestFiniteMagnitude)
                    .navigationDestination(isPresented: $goHome, destination: { ProductView() })

                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()

                })
                .padding(.vertical, 40)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(.white)
                .roundedCorner(80, corners: [.topLeft, .topRight])
            }
            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
            .background(Color.blue)

            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TitleToolBarItem(title: PAGE_TEXT["title"]![4], color: .white)
                }
            }
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
