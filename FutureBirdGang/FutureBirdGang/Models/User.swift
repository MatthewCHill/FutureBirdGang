//
//  User.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class User {
    
    enum Key {
        static let userName = "userName"
        static let cohort = "cohort"
        static let description = "description"
        static let profilePicture = "profilePictureURL"
        static let uuid = "uuid"
        static let collectionType = "userInfo"
    }
    
    let userName: String
    let cohort: String
    let description: String
    var profilePicture: String?
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [
            Key.userName: self.userName,
            Key.cohort: self.cohort,
            Key.description: self.description,
            Key.profilePicture: self.profilePicture,
            Key.uuid: self.uuid
        ]
    }
    
    init(userName: String, cohort: String, description: String, profilePicture: String, uuid: String = UUID().uuidString) {
        self.userName = userName
        self.cohort = cohort
        self.description = description
        self.profilePicture = profilePicture
        self.uuid = uuid
    }
} // end of class

extension User {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let userName = dictionary[Key.userName] as? String,
              let cohort = dictionary[Key.cohort] as? String,
              let description = dictionary[Key.description] as? String,
              let profilePicture = dictionary[Key.profilePicture] as? String,
              let uuid = dictionary[Key.uuid] as? String else { return nil }
            
                self.init(userName: userName, cohort: cohort, description: description, profilePicture: profilePicture, uuid: uuid)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
