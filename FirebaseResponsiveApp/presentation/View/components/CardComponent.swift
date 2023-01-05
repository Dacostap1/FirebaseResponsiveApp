//
//  CardComponent.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 17/12/22.
//

import SwiftUI
import FirebaseStorage

struct CardComponent: View {
    @ObservedObject var firestoreViewModel : FirestoreCrudViewModel
    
    var game: GameModel
    var platform: String
    
    var body: some View {
        VStack(spacing: 20){
            //FALTA APRENDER A USARLO
//            AsyncImage(url: URL(string: game.portada)) { image in
//                image
//                    .resizable()
//                          .aspectRatio(contentMode: .fill)
//                          .frame(width: 300, height: 200, alignment: .topLeading)
//                          .cornerRadius(20)
//                          .clipped()
//
//            } placeholder: {
//                Image(systemName: "photo.fill")
//                    .resizable()
//                          .aspectRatio(contentMode: .fill)
//                          .frame(width: 300, height: 200, alignment: .center)
//                          .cornerRadius(20)
//                          .clipped()
//            }

            AsyncImage(url: URL(string: game.portada)!) { phase in // 1
                      if let image = phase.image { // 2
                          // if the image is valid
                          image
                              .resizable()
                              .aspectRatio(contentMode: .fill)
                              .frame(width: 300, height: 200, alignment: .center)
                              .cornerRadius(20)
                              .clipped()
                          
                      } else if phase.error != nil { // 3
                          // some kind of error appears
                          Text("No image available")
                      } else {
                          //appears as placeholder image
                          ProgressView().font(.largeTitle)
                      }
            }.frame(width: 300, height: 200, alignment: .center)
            
//           ImageFirebase(imageUrl: game.portada)
            Text(game.titulo)
                .font(.subheadline)
                .bold()
                .foregroundColor(.black)
            Button(action: {
                Task{
                  try await firestoreViewModel.delete(game: game, platform: platform)
                }

            }) {
                Text("Eliminar")
                    .foregroundColor(.red)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
                    .background(
                        Capsule().stroke(.red)
                    )
            }
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
    }
}

