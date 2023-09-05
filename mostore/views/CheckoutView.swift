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

    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 20, weight: .bold)]
        // UINavigationBar.appearance().backgroundColor = UIColor.green
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false, content: {
                Spacer()
                Spacer()
                VStack(spacing: 50, content: {
                    VStack {
                        Text(PAGE_TEXT["text"]![3])
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)

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
                            .frame(width: .infinity, height: .infinity, alignment: .leading)
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
                        .frame(width: .infinity, height: .infinity, alignment: .leading)

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
                    .onAppear {
                        CheckApi().loadTotal(orderId: "64f2a35e89ece621daa0a330") { amount in
                            self.amount = amount
                            self.tax = (amount * 13) / 100
                            self.total = amount + tax
                        }
                    }

                    Button(action: {
                        makePayment()
                    }, label: {
                        Text("\(PAGE_TEXT["button"]![3])")
                            .frame(maxWidth: .infinity)
                    })
                    .padding(.vertical, 15)
                    .accentColor(.white)
                    .background(.blue)
                    .cornerRadius(40)
                    .fontWeight(.bold)
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    .navigationDestination(isPresented: $isPaid, destination: { ConfirmationView() })

                })
                .actionSheet(isPresented: $isSheetActive, content: getActionSheet)
                .alert(isPresented: $isFailed, content: getAlert)

            })
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .navigationBarTitle(PAGE_TEXT["title"]![3], displayMode: .inline)
        }
    }

    func makePayment() {
        CheckApi().makePayment(userId: "64ed3a3efc29f826a41df4c2", orderId: "64f2a35e89ece621daa0a330", amount: total, lastFour: "1234") { paid in
            isPaid = paid
        }
    }

    func getActionSheet() -> ActionSheet {
        let useSaved: ActionSheet.Button = .default(Text("Use Saved Card")) {
            cardNumber = "6876797634764768546979"
            expiry = "02/23"
            cvv = "123"
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
