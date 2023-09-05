//
//  layout.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-24.
//

import Foundation
import SwiftUI

struct ExtTextFieldView: View {
    let placeholder: String
    let placement: TextAlignment
    let id: String
    @Binding var value: String
    var body: some View {
        TextField(placeholder, text: $value)
            .accessibilityLabel(placeholder)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .trailing)
            .multilineTextAlignment(placement)
            .id(id)
    }
}

struct ExtTotalView: View {
    var heading: String
    var amount: Double
    var body: some View {
        HStack(content: {
            Text(heading)
                .font(.headline)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("$\(amount, specifier: "%0.2f")")
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .trailing)
        })
        .frame(width: .infinity, height: .infinity, alignment: .leading)
    }
}

struct FloatingButton: View {
    let action: () -> Void
    let icon: String
    let fg: Color
    let bg: Color
    let label: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    Image(systemName: icon)
                        .font(.system(size: 25))
                        .foregroundColor(fg)
                }
                .frame(width: 60, height: 60)
                .accessibilityLabel(label)
                .background(bg)
                .cornerRadius(30)
                .shadow(radius: 10)
                .offset(x: -25, y: 10)
            }
        }
    }
}

struct LabelAlignment: UIViewRepresentable {
    var text: String
    var textAlignmentStyle: TextAlignmentStyle
    var width: CGFloat
    var size: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.font = label.font.withSize(size)
        label.textAlignment = NSTextAlignment(rawValue: textAlignmentStyle.rawValue)!
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}

enum TextAlignmentStyle: Int {
    case left = 0, center = 1, right = 2, justified = 3, natural = 4
}

var NoItemLayout: some View {
    VStack {
        Text(PAGE_TEXT["text"]![15])
            .multilineTextAlignment(.center)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
    }
}

struct SettingRowView: View {
    var title: String
    var systemImageName: String

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: systemImageName)
            Text(title)
        }
    }
}

struct ExtBrand: View {
    var body: some View {
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
}

struct ExtButtonView: View {
    let name: String
    @Binding var response: Any
    let onRequestDone: Any
    let topPadding: Double
    let acColor: Color
    let bgColor: Color
    let corner: CGFloat
    let size: Font
    var body: some View {
        Button(action: {
            response = onRequestDone
        }, label: {
            Text(name)
                .frame(maxWidth: .infinity)

        })
        .padding(.vertical, topPadding)
        .accentColor(acColor)
        .font(size)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(corner)
    }
}

struct ExtNavButtonView: View {
    let name: String
    @Binding var isMovable: Bool
    let isActive: Bool
    let destination: AnyView
    let topPadding: Double
    let acColor: Color
    let bgColor: Color
    let corner: CGFloat
    let size: Font
    var body: some View {
        Button(action: {
            isMovable = isActive
        }, label: {
            Text(name)
                .frame(maxWidth: .infinity)

        })
        .padding(.vertical, topPadding)
        .accentColor(acColor)
        .font(size)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .background(bgColor)
        .cornerRadius(corner)
        .navigationDestination(isPresented: $isMovable) {
            destination
        }
    }
}


extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    }


struct ExtAsyncImage: View {
    var imageURL: String
    var size: CGFloat
    var shape: any Shape
    var body: some View {
        AsyncImage(url: URL(string: imageURL)!) { phase in
            switch phase {
            case .empty:
                Image(systemName: "photo")
                    .frame(width: size, height: size)
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fit)
                    .transition(.scale(scale: 0.1, anchor: .center))
                    .frame(maxWidth: size, maxHeight: size)
                
            case .failure:
                Image(systemName: "photo")
                    .frame(width: size, height: size)
            @unknown default:
                ProgressView()
                    .frame(width: size, height: size)
            }
        }
        .frame(maxWidth: size, maxHeight: size)
        .background(Color.white)
        .clipShape(AnyShape(shape))
    }
}
