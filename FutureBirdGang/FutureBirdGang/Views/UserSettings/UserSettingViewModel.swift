//
//  UserSettingViewModel.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

protocol UserSettingsViewModelDelegate: AnyObject {
    func imageSuccessfullySaved()
}
class UserSettingsViewModel {
    
    // MARK: - Properties
    let service: FirebaseService
    var delegate: UserSettingsViewModelDelegate?
    var user: User?
    
    init(service: FirebaseService = FirebaseService(), delegate: UserSettingsViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func saveUserInfo(userName: String, cohort: String, description: String, profilePicture: UIImage) {
        guard let userUUID = Auth.auth().currentUser?.uid else { return }
        if let user {
            user.userName = userName
            user.cohort = cohort
            user.description = description
            user.uuid = userUUID
            service.update(user, with: profilePicture) {
                self.delegate?.imageSuccessfullySaved()
            }
        } else {
            service.save(username: userName, cohort: cohort, description: description, profilePicture: profilePicture) {
                self.delegate?.imageSuccessfullySaved()
            }
        }
    }
    
    func signOut() {
        service.signOut()
    }
}
