//
//  ListView.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 19/12/22.
//

import SwiftUI

struct ListView: View {
    @Environment(\.horizontalSizeClass) var width
    @StateObject var firestoreCrud = FirestoreCrudViewModel()
    var platform : String
    
    @State private var gameSelected  : GameModel? = nil
    
    //Detecta dispositivo actual
    var device = UIDevice.current.userInterfaceIdiom
    
    
    func getColumns () -> Int {
        //TODO: Buscar doc porq no detecta el cambio de horientacion en iphone
        if(device == .phone && width == .compact) {
            //solo iphone vertical devuelve 1
            return 1
        }
        
        //Ipad y iphone horizontal devuelven 3
        return 3
    }
 
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: getColumns()), spacing: 5) {
                ForEach(firestoreCrud.gamesList, id: \.id){item in
                    CardComponent(firestoreViewModel: firestoreCrud, game: item, platform: platform)
                        .onTapGesture {
                            gameSelected = item
                        }
                        .padding()
                }.sheet(item: $gameSelected, content: { item in
                    EditItem(firestoreViewModel: firestoreCrud, platform: platform, game: item).presentationDetents([.large]) //se puede customizar
                })
            }
        }.onAppear{
            print("test")
            Task{ //Cuando desaparece la vista se cancela la tarea
                await firestoreCrud.getGames(platform: platform)
            }
          
        }
    }
}

