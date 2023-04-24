//
//  FirebaseService.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23

import UIKit
import FirebaseFirestore
import FirebaseStorage

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

protocol FireBaseSyncable {
    func save(username: String, cohort: String, description: String, profilePicture: UIImage, completion: @escaping() -> Void)
}

struct FirebaseService: FireBaseSyncable {
    
    // MARK: - Properties
    let ref =  Firestore.firestore()
    let storage = Storage.storage().reference()
    
    
    // MARK: - Functions
    func save(username: String, cohort: String, description: String, profilePicture: UIImage, completion: @escaping() -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(profilePicture, with: uuid) { result in
            switch result {
            case .success(let profilePicture):
                let user = User(userName: username, cohort: cohort, description: description, profilePicture: profilePicture.absoluteString)
                ref.collection(User.Key.collectionType).document(user.uuid).setData(user.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
    
    func loadProfile(completion: @escaping (Result<[User], FirebaseError>) -> Void) {
        ref.collection(User.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
            
            guard let docSnapshotArray = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }
            
            let dictionaryArray = docSnapshotArray.compactMap { $0.data() }
            let user = dictionaryArray.compactMap { User(fromDictionary: $0) }
            completion(.success(user))
            
        }
    }
    
    func delete(user: User) {
        ref.collection(User.Key.collectionType).document(user.uuid).delete()
        deleteImage(from: user)
        
        
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result<URL, FirebaseError>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.05) else { return }
        
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        let uploadTask = storage.child(User.Key.profilePicture).child(uuidString).putData(imageData, metadata: uploadMetadata) {
            _, error in
            
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("uploaded image")
            storage.child(User.Key.profilePicture).child(uuidString).downloadURL { url, error in
                if let error {
                    print(error.localizedDescription)
                    completion(.failure(.firebaseError(error)))
                    return
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.firebaseError(snapshot.error!)))
            return
        }
    }
    func fetchImage(from user: User, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(User.Key.profilePicture).child(user.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(.failedToUnwrapData))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.firebaseError(error)))
                return
            }
        }
    }
    
    func deleteImage(from user: User) {
        storage.child(User.Key.profilePicture).child(user.uuid).delete(completion: nil)
    }
    
    func update(_ user: User, with newImage: UIImage, completion: @escaping () -> Void) {
        saveImage(newImage, with: user.uuid) { result in
            switch result {
            case .success(let profilePicture):
                user.profilePicture = profilePicture.absoluteString
                ref.collection(User.Key.collectionType).document(user.uuid).setData(user.dictionaryRepresentation)
            case .failure(let failure):
                print(failure)
                return
            }
        }
    }
}

