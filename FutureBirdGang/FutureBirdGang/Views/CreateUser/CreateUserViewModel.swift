//
//  CreateUserViewModel.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import Foundation
import UIKit
import FirebaseAuth

struct CreateUserViewModel {
    
    func createUser(email: String, password: String, confrimPassword: String, completion: @escaping (Bool, Error?) -> Void) {
        if password == confrimPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("Error Creating User", error.localizedDescription)
                    completion(false, error)
                }
                if let authResult {
                    let user = authResult.user
                    print(user.uid)
                    completion(true, nil)
                }
            }
        } else {
            print("Password Dont Match")
            completion(false, NSError(domain: "Invalid Input", code: -1, userInfo: [NSLocalizedDescriptionKey: "Passwords don't match"]))
        }
    }
} // End of class
