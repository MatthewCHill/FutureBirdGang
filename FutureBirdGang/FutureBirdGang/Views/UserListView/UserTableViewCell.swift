//
//  UserTableViewCell.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet weak var profilePictureImageView: ServiceRequestingImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cohortLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func updateUI(user: User) {
        userNameLabel.text = user.userName
        cohortLabel.text = user.cohort
        descriptionLabel.text = user.description
        
        profilePictureImageView.fetchImage(using: user)
    }
}


