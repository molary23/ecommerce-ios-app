//
//  CheckoutView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct CheckoutView: View {
    @StateObject var checkController = CheckController()
    @EnvironmentObject var cartManager: CartManager
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 50, content: {
                    VStack {
                        Text(PAGE_TEXT["text"]![3])
                            .font(.headline)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)

                        HStack(content: {
                            Circle()
                                .frame(maxWidth: 80, maxHeight: 80, alignment: .leading)
                                .foregroundColor(.white)
                                .overlay {
                                    Image(systemName: "creditcard")
                                        .foregroundColor(.red)
                                        .font(.title)
                                }

                            TextFieldView(placeholder: "\(PAGE_TEXT["input"]![9])", placement: .trailing, id: "cardNumber", value: $checkController.cardNumber).textFieldStyle(.plain)

                        }).padding()
                            .background(Color("off-white"))
                            .cornerRadius(8)
                            .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .infinity, alignment: .leading)
                    }

                    VStack {
                        HStack(content: {
                            Text(PAGE_TEXT["text"]![4])
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(PAGE_TEXT["text"]![5])
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .trailing)

                        })

                        HStack(content: {
                            HStack(spacing: 2) {
                                TextFieldView(placeholder: "\(PAGE_TEXT["input"]![5])", placement: .leading, id: "month", value: $checkController.month).textFieldStyle(.plain)
                                    .frame(maxWidth: 30)
                                Text("/")
                                    .foregroundColor(.gray)

                                TextFieldView(placeholder: "\(PAGE_TEXT["input"]![10])", placement: .leading, id: "year", value: $checkController.year).textFieldStyle(.plain)
                                    .frame(maxWidth: 30)
                            }

                            SecureField("\(PAGE_TEXT["input"]![6])", text: $checkController.cvv)
                                .textFieldStyle(.plain)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .multilineTextAlignment(.trailing)

                        })

                        .padding(.vertical, 40)
                        .padding(.horizontal, 10)
                        .background(Color("off-white"))
                        .cornerRadius(8)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                        HStack(alignment: .center, content: {
                            Toggle(isOn: $checkController.savePayment) {
                                Text("Save Payment")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .disabled(checkController.alreadySaved)

                        })
                        .padding(.horizontal, 4)
                    }

                    VStack(spacing: 30) {
                        TotalRow(heading: PAGE_TEXT["text"]![6], amount: checkController.amount)
                        TotalRow(heading: PAGE_TEXT["text"]![7], amount: checkController.tax)
                        TotalRow(heading: PAGE_TEXT["text"]![8], amount: checkController.total)
                    }

                })
                .actionSheet(isPresented: $checkController.isSheetActive, content: getActionSheet)

                .alert(isPresented: $checkController.isFailed, content: getAlert)
                .onAppear {
                    checkController.getAmount()
                    let storedNumber = preferences.string(forKey: numberKey) ?? ""
                    if storedNumber.isEmpty {
                        checkController.getCard()
                    } else {
                        checkController.isSheetActive = true
                    }
                }
                .onDisappear(perform: {
                    if checkController.isPaid {
                        cartManager.removeAllFromCart()
                    }
                })

            })
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                NavigationButton(name:
                    Text("\(PAGE_TEXT["button"]![3])")
                        .frame(maxWidth: .greatestFiniteMagnitude)
                    , destination: AnyView(ConfirmationView()), topPadding: 15, acColor: .white, bgColor: .blue, corner: 40, fontSize: .title2, isMovable: $checkController.isPaid, action: { checkController.makePayment() })

                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                    .padding(.horizontal, 20)
                    .disabled(!checkController.validateCard())
            )

            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    TitleToolBarItem(title: PAGE_TEXT["title"]![3])
                }
            }
        }
    }

    func getActionSheet() -> ActionSheet {
        let useSaved: ActionSheet.Button = .default(Text("Use Saved Card")) {
            checkController.cardNumber = "************" + checkController.getLastFour(number: checkController.card.number ?? "")
            checkController.month = "\(checkController.card.month ?? "")"
            checkController.year = "\(checkController.card.year ?? "")"
            checkController.cvv = checkController.card.cvv ?? ""
            checkController.alreadySaved = true
        }

        let useNew: ActionSheet.Button = .default(Text("Use New Card")) {
            checkController.isSheetActive = false
        }

        let useCancel: ActionSheet.Button = .cancel({ checkController.isSheetActive = false })

        return ActionSheet(title: Text("Payment Method"), message: Text("You have a saved Payment Card"), buttons: [useSaved, useNew, useCancel])
    }

    func getAlert() -> Alert {
        return Alert(title: Text("Payment failed! Try again later."))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(CartManager())
    }
}
