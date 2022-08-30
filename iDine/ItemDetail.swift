//
//  ItemDetail.swift
//  iDine
//
//  Created by Yigit Ozdamar on 29.08.2022.
//

import SwiftUI



struct ItemDetail: View {
    
    let item : MenuItem
    @EnvironmentObject var order : Order
    @State private var isFavorite = false
    @State private var orderAlert = false
    
    var body: some View {
        VStack{
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description)
                .padding()
            
            Button("Order This"){
                order.add(item: item)
                self.orderAlert.toggle()
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
            .foregroundColor(.white)
            .background(.green)
            .cornerRadius(25)
            
            Spacer()
        }.navigationTitle(item.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem {
                    Button {
                        order.addFavorites(item: item)
                        self.isFavorite.toggle()
                        
                    } label: {
                        Image(systemName: self.isFavorite == true ? "star.fill" : "star")
                                  
                    }
                }
                
            }
            .alert("Ordered!", isPresented: $orderAlert) {
                //
            } message: {
                Text(item.name)
            }

           
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ItemDetail(item:MenuItem.example)
                .environmentObject(Order())
        }
    }
}
