//
//  UserSettingsViewController.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var cohortTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
    // MARK: - Properties
    var viewModel: UserSettingsViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserSettingsViewModel(delegate: self)
        setUpImageView()
        self.hideKeyboardWhenDone()
    }
    // MARK: - functions
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let userName = userNameTextField.text,
              let cohort = cohortTextField.text,
              let description = descriptionTextField.text,
              let image = profileImageView.image else { return }
            
            self.viewModel.saveUserInfo(userName: userName, cohort: cohort, description: description, profilePicture: image)
        }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.signOut()
    }
    
    func setUpImageView() {
           profileImageView.contentMode = .scaleAspectFill
           profileImageView.isUserInteractionEnabled = true
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
           profileImageView.addGestureRecognizer(tapGesture)
       }
       
    @objc func imageViewTapped() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
} // End of class

// MARK: - Extensions
extension UserSettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        profileImageView.image = image
    }
}

extension UserSettingsViewController: UserSettingsViewModelDelegate {
    func imageSuccessfullySaved() {
        self.navigationController?.popViewController(animated: true)
    }
}
