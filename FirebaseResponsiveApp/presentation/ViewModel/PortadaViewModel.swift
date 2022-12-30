//
//  PortadaViewModel.swift
//  FirebaseResponsiveApp
//
//  Created by Daniel Acosta on 19/12/22.
//

import Foundation
import FirebaseStorage

class PortadaViewModel : ObservableObject {
    @Published var data : Data? = nil
    
    init(imageUrl: String) {
        let storageImage = Storage.storage().reference(forURL: imageUrl)
        storageImage.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error?.localizedDescription{
                print(error)
            }else{
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }
    }
}
