//
//  SignInViewController.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: -
    var viewModel: SignInViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInViewModel(delegate: self)
        self.hideKeyboardWhenDone()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, email != "" else { return }
        guard let password = passwordTextField.text, password != "" else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error {
                print("Error signing in", error.localizedDescription)
                let alert = UIAlertController(title: "Error Logging In", message: "It seems that either your password or email is incorrect", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
                    print("User says Okay")
                }))
                self.present(alert, animated: true)
            }
            
            self.viewModel.signIn(email: email, password: password)
            
        }
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func signInSuccessfully() {
    }
}

