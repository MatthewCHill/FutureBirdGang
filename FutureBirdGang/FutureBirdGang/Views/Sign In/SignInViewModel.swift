//
//  SignInViewModel.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//
import Foundation
import FirebaseAuth

protocol SignInViewModelDelegate: AnyObject {
    func signInSuccessfully()
}

struct SignInViewModel {
    
    // MARK: - propeties
    var delegate: SignInViewModelDelegate?
    
    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Error Signing In", error.localizedDescription)
            }
            if let result {
                let user = result.user
                print(user.uid)
            }
        }
    }
}
