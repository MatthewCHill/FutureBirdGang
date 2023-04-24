//
//  CreateUserViewController.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class CreateUserViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var viewModel: CreateUserViewModel!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel()
        self.hideKeyboardWhenDone()
    }
    
    // MARK: - fucntions
    func presentMainVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "TabBarController")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
    
    func presentErrorAlertController(error: String) {
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text,
              let confrimPassword = confirmPasswordTextField.text else { return }
        
        viewModel.createUser(email: email, password: password, confrimPassword: confrimPassword) { success, error in
            if success == true {
                self.presentMainVC()
            } else {
                self.presentErrorAlertController(error: error?.localizedDescription ?? "")
            }
        }
    }
} // End of class
