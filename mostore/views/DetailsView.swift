//
//  DetailsView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-19.
//

import SwiftUI

struct LabelAlignment: UIViewRepresentable {
    var text: String
    var textAlignmentStyle: TextAlignmentStyle
    var width: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
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

struct DetailsView: View {
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("shopping")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 400)
                        .clipped()
                        .overlay(
                            HStack(content: {
                                Button(action: {
                                    print("button pressed")

                                }) {
                                    Image(systemName: "multiply.circle")
                                        .renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                                        .font(.title)
                                        .foregroundColor(Color.gray)
                                }
                                

                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(.vertical, 15)
                            .padding(.horizontal, 30)
                        )
                }

                VStack(spacing: 10, content: {
                    Text("Tote Bag")
                        .font(.title2)
                        .frame(maxWidth: .greatestFiniteMagnitude)

                    Text("$50.77")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                    VStack(spacing: 10, content: {
                        Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                        LabelAlignment(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque blandit gravida ipsum ac commodo. Cras ultricies lectus vitae purus tempus, sit amet laoreet urna eleifend. Pellentesque molestie convallis nulla vel mattis. Aenean bibendum sem a metus commodo tempus. Integer quis neque sem. Nullam a aliquet augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam convallis pellentesque dui nec accumsan. Aliquam et placerat augue. Curabitur at dui enim. Curabitur non ante et urna tristique pellentesque quis vel tortor. Nunc varius mi eu ultricies mollis. Duis vel elit faucibus, molestie felis vitae, imperdiet eros. Vestibulum a tellus id nibh laoreet interdum.", textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 20)
                        

                    })
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                   
                })
                .padding()
             
            }
           
        }
        .overlay(
          /*  HStack(content: {
                Button("Add to Cart") {}
                    .padding(.vertical, 8.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            // .padding(.vertical, 15)
             .padding(.horizontal, 10)*/
            FloatingButton(action: {print("Add to Cart")}, icon: "cart.badge.plus", fg:Color.white, bg:Color.blue, label: "Add to cart")
            
        )
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
