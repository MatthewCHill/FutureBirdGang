//
//  UserListViewModel.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import Foundation

protocol UserListViewModelDelegate: AnyObject {
    func usersLoadedSuccessfully()
}

class UserListViewModel {
    
    // MARK: - Properties
    var users: [User] = []
    private var service: FireBaseSyncable
    private weak var delegate: UserListViewModelDelegate?
    
    init(service: FireBaseSyncable = FirebaseService(), delegate: UserListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func loadUsers () {
        service.loadProfile { result in
            switch result {
            case .success(let users):
                self.users = users
                self.delegate?.usersLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
