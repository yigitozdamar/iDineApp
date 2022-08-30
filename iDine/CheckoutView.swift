//
//  CheckoutView.swift
//  iDine
//
//  Created by Yigit Ozdamar on 29.08.2022.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order : Order
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
    let pickupTimes = ["Now","Today","Tomorrow"]
    
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    @State private var pickupTime = "Today"
    
    var totalPrice : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total+tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self){
                        Text($0)
                    }
                }
                Toggle("Add iDine Loyalty Card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section("Add a tip?"){
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self){
                        Text("%\($0)")
                    }
                }.pickerStyle(.segmented)
            }
            Section{
                Picker("Pickup Time", selection: $pickupTime) {
                    ForEach(pickupTimes, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.automatic)
            }
            
            Section(header:
                        Text("TOTAL: \(totalPrice)")
                .font(.largeTitle)
            ) {
                Button("Confirm order") {
                    showingPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            let confirm = Alert.Button.default(Text("Confirm 🚨")) { print("Confirmed.") }
            let cancel = Alert.Button.destructive(Text("Cancel")) { /*do nothing*/ }
            
            return Alert(title: Text("Order Confirmed"),
                         message: Text("Your total was \(totalPrice) – thank you!"),
                         primaryButton: confirm,
                         secondaryButton: cancel)
        }
        
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(Order())
    }
}
