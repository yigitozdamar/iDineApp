//
//  FavoritesView.swift
//  iDine
//
//  Created by Yigit Ozdamar on 30.08.2022.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var order : Order
    
    func deleteItems(at offSets: IndexSet){
        order.favorites.remove(atOffsets: offSets)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(order.favorites){ favorite in
                        Text(favorite.name)
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Favorites")
            .listStyle(.insetGrouped)
            .toolbar{
                EditButton()
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(Order())
    }
}
