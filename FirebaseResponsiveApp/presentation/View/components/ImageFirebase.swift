//
//  ImageFirebase.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 19/12/22.
//

import SwiftUI

struct ImageFirebase: View {
    
    let imagePlaceholder = UIImage(systemName: "photo")
    @ObservedObject var imageLoader : PortadaViewModel
    
    init(imageUrl: String) {
        //Inicializa imageLoader con el ViewModel el cual tiene la logica para obtener data
        imageLoader = PortadaViewModel(imageUrl: imageUrl)
    }
    
    var image : UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? imagePlaceholder!)
            .resizable()
            .cornerRadius(20)
            .shadow(radius: 5)
            .aspectRatio(contentMode: .fit)
    }
}
