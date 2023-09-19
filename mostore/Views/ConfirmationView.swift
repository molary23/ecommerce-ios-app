//
//  ConfirmationView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func roundedCorner(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct ConfirmationView: View {
    @State private var goHome: Bool = false
 //   @EnvironmentObject var user: User
    init() {
        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
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

                    Spacer()

                    ExtNavButtonView(name: "\(PAGE_TEXT["button"]![1])", isMovable: $goHome, isActive: continueShopping(), destination: AnyView(ProductView()), topPadding: 15.0, acColor: .white, bgColor: .blue, corner: 40, size: .title2)

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

            .navigationBarTitle(PAGE_TEXT["title"]![4], displayMode: .inline)
            .navigationBarBackButtonHidden(true)
        }
    }

    func continueShopping() -> Bool {
        return true
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
            
            //.environmentObject(User())
    }
}
