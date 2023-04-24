//
//  ServiceRequestingImageView.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class ServiceRequestingImageView: UIImageView {
    
    let service = FirebaseService()
    var user: User?

    func fetchImage(using user: User) {
        service.fetchImage(from: user) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
