//
//  OrderView.swift
//  iDine
//
//  Created by Yigit Ozdamar on 29.08.2022.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order : Order
    
    func deleteItems(at offSets: IndexSet){
        order.items.remove(atOffsets: offSets)
    }
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(order.items) { item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                Section{
                    NavigationLink(destination:
                                    CheckoutView()){
                        Text("Place Order")
                    }.disabled(order.items.isEmpty)
                    
                }
            }
            .navigationTitle("Order")
            .listStyle(.insetGrouped)
            .toolbar{
                EditButton()
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
