//
//  CheckoutView.swift
//  mostore
//
//  Created by Azeez Adeola Hassan on 2023-08-21.
//

import SwiftUI

struct CheckoutView: View {
    @State private var expiry: String = ""
    @State private var cvv: String = ""
    @State private var cardNumber: String = ""
    @State private var response: Any = false
    @State private var total: Double = 0
    @State private var tax: Double = 0
    @State private var amount: Double = 0
    @State private var savePayment: Bool = false
    @State private var isSheetActive: Bool = false
    @State private var alreadySaved: Bool = false
    @State private var isPaid: Bool = false
    @State private var isFailed: Bool = false
    @State private var card: Card = Card()

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        // UINavigationBar.appearance().backgroundColor = UIColor.green
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

                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![9], placement: .trailing, id: "cardNumber", value: $cardNumber).textFieldStyle(.plain)

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
                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![5], placement: .leading, id: "expiry", value: $expiry).textFieldStyle(.plain)
                            ExtTextFieldView(placeholder: PAGE_TEXT["input"]![6], placement: .trailing, id: "cvv", value: $cvv).textFieldStyle(.plain)

                        })

                        .padding(.vertical, 40)
                        .padding(.horizontal, 10)
                        .background(Color("off-white"))
                        .cornerRadius(8)
                        .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .leading)

                        HStack(alignment: .center, content: {
                            Toggle(isOn: $savePayment) {
                                Text("Save Payment")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .disabled(alreadySaved)

                        })
                        .padding(.horizontal, 4)
                    }

                    VStack(spacing: 30) {
                        ExtTotalView(heading: PAGE_TEXT["text"]![6], amount: amount)
                        ExtTotalView(heading: PAGE_TEXT["text"]![7], amount: tax)
                        ExtTotalView(heading: PAGE_TEXT["text"]![8], amount: total)
                    }

                })
                .actionSheet(isPresented: $isSheetActive, content: getActionSheet)

                .alert(isPresented: $isFailed, content: getAlert)
                .onAppear {
                    CheckApi().loadTotal(userId: storedId) { amount in

                        self.amount = amount
                        self.tax = (amount * 13) / 100
                        self.total = amount + tax
                    }

                    if storedNumber.isEmpty {
                        CheckApi().loadCard(userId: storedId) { card in
                            self.card = card
                            if card.number != nil {
                                isSheetActive = true
                            }
                        }
                    } else {
                        isSheetActive = true
                    }
                }

            })
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .overlay(
                Button(action: {
                    makePayment()

                }, label: {
                    Text("\(PAGE_TEXT["button"]![3])")
                        .frame(maxWidth: .greatestFiniteMagnitude)
                })
                .padding(.vertical, 15)
                .accentColor(.white)
                .background(.blue)
                .cornerRadius(40)
                .fontWeight(.bold)
                .font(.title2)
                .frame(maxWidth: .greatestFiniteMagnitude)
                .navigationDestination(isPresented: $isPaid, destination: { ConfirmationView() })
                .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: .greatestFiniteMagnitude, alignment: .bottom)
                .padding(.horizontal, 20)
                .disabled(cardNumber.count < 16 || expiry.count < 5 || cvv.count < 3)
            )
            .navigationBarTitle(PAGE_TEXT["title"]![3], displayMode: .inline)
        }
    }

    func makePayment() {
        if savePayment {
            CheckApi().saveCard(userId: storedId, number: cardNumber, month: expiry.components(separatedBy: "/")[0], year: expiry.components(separatedBy: "/")[1], cvv: cvv) { card in
                print(card)
            }
            CheckApi().makePayment(userId: storedId, amount: total, lastFour: "1234") { paid in
                isPaid = paid
            }
        } else {
            CheckApi().makePayment(userId: storedId, amount: total, lastFour: "1234") { paid in
                isPaid = paid
            }
        }
    }

    func getActionSheet() -> ActionSheet {
        let useSaved: ActionSheet.Button = .default(Text("Use Saved Card")) {
            cardNumber = card.number ?? ""
            expiry = "\(card.month ?? "")\\\(card.year ?? "")"
            cvv = card.cvv ?? ""
            alreadySaved = true
        }

        let useNew: ActionSheet.Button = .default(Text("Use New Card")) {
            isSheetActive = false
        }

        let useCancel: ActionSheet.Button = .cancel({ isSheetActive = false })

        return ActionSheet(title: Text("Payment Method"), message: Text("You have a saved Payment Card"), buttons: [useSaved, useNew, useCancel])
    }

    func getAlert() -> Alert {
        return Alert(title: Text("Payment failed. Try again later."))
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
