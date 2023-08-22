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
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("button pressed")

                }) {
                    Image(systemName: "arrow.left")
                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                        .font(.title2)
                        .frame(maxWidth: 40, alignment: .leading)
                }

                Text("Order Confirmation")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)

            }.foregroundColor(.white)
                .padding(.horizontal, 20)
                .frame(maxWidth: .greatestFiniteMagnitude, alignment: .top)


            VStack {
                Text("Thanks")
                    .font(.largeTitle)
                    .bold()
            }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .center)

            VStack(alignment: .center, spacing: 20, content: {
                Image(systemName: "checkmark.circle.fill")
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .font(.custom("checkmark", fixedSize: 100))
                    .foregroundColor(Color.orange)
                    .clipped()

                Spacer()

                VStack(spacing: 8) {
                    Text("Thank you for your purchase.")
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity)

                    Text("Your order will be shipped in 2-5 days. Your order will be")
                        .font(.title3)
                        .frame(width: .infinity, height: .infinity)
                        .multilineTextAlignment(.center)

                    Text("Tracking info will be sent to you asap.")
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                }

                Spacer()
                Button(STRING_TUPLE.9) {}
                    .padding(.vertical, 15.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .font(.title2)

                Spacer()

            })
            .compositingGroup()
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .background(.white)
            .roundedCorner(80, corners: [.topLeft, .topRight])
            .edgesIgnoringSafeArea(.bottom)
        }
        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude)
        .background(Color.blue)
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
