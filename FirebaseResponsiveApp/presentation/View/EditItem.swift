//
//  EditItem.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 19/12/22.
//

import SwiftUI


//enum Routes: Hashable {
//    case create_image
//}

struct EditItem: View {
    @ObservedObject var firestoreViewModel : FirestoreCrudViewModel    
    var platform : String
    var game : GameModel
    
    
    @State private var titulo = ""
    @State private var desc = ""
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    @State private var loading = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack{
                    //usamos navigationDestination para navegar en base a una variable
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear{
                            print("onApper")
                            titulo = game.titulo
                        }
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .onAppear{
                            desc = game.desc
                        }
                  
                    Button(action: {
                        mostrarMenu.toggle()
                    }) {
                        Text("Cargar Imagen")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }.confirmationDialog(Text("menu"), isPresented: $mostrarMenu) {
                        Button(action: {
                            source = .camera
                            imagePicker.toggle() //Se activa el navigation Link
                        }) {
                            Text("Camara")
                        }
                        Button(action: {
                            source = .photoLibrary
                            imagePicker.toggle() //Se activa el navigation Link
                        }) {
                            Text("Libreria")
                        }
                    }
                    
                    if imageData.count != 0 {
                        Image(uiImage: UIImage(data: imageData)!)
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(25)
                    }
                    
                    Button(action: {
                        Task{
                            loading = true
                            print(titulo, desc)
                            if(imageData.isEmpty){
                               try await firestoreViewModel.update(titulo: titulo, desc: desc, portada: nil, game: game, platform: platform)
                            }else{
                               try await firestoreViewModel.update(titulo: titulo, desc: desc, portada: imageData, game: game, platform: platform)
                            }
                            
                            print("before dismiss")
                            
                            dismiss.callAsFunction()
             
                        }
             
                    }) {
                        Text("Guardar")
                            .foregroundColor(.black)
                            .bold()
                            .font(.largeTitle)
                    }
                    
                    if loading {
                        Text("Guardando imagen").foregroundColor(.black)
                        ProgressView()
                    }
                    
                    Spacer()
                    
                }.padding()
                .navigationDestination(isPresented: $imagePicker) {
                    ImagePicker(show: $imagePicker, image: $imageData, source: $source)
                }

            }
        }
        .navigationViewStyle( StackNavigationViewStyle())
     
    }
}


