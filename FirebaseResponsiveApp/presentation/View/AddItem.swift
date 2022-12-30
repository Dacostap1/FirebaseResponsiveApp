//
//  AddItem.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 18/12/22.
//

import SwiftUI

struct AddItem: View {
    
    @StateObject var FirestoreCrud = FirestoreCrudViewModel()
    
    let consolas = ["playstation", "xbox", "nintendo"]
    
    @State private var platform = "playstation"
    @State private var titulo = ""
    @State private var desc = ""
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    @State private var loading = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack{
//                    NavigationLink(destination: ImagePicker(show: $imagePicker, image: $imageData, source: source), isActive: $imagePicker) {
//                        EmptyView()
//                    }.toolbar(.hidden)
                    
                    TextField("Titulo", text: $titulo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextEditor(text: $desc)
                        .frame(height: 200)
                    Picker("Consolas",selection: $platform){
                        ForEach(consolas, id:\.self){item in
                            Text(item).foregroundColor(.black)
                        }
                    }.pickerStyle(.wheel)
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
                            do{
                                loading = true
                                try await  FirestoreCrud.saveAsync(titulo: titulo, desc: desc, platform: platform, portada: imageData)
                                titulo = ""
                                desc = ""
                                imageData = .init(capacity: 0) //clean image
                                loading = false
                            }catch{
                                print(error)
                            }
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
        }.navigationViewStyle( StackNavigationViewStyle())
     
    }
}


