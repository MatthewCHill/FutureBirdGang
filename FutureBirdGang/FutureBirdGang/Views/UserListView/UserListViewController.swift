//
//  UserListViewController.swift
//  FutureBirdGang
//
//  Created by Matthew Hill on 4/24/23.
//

import UIKit

class UserListViewController: UIViewController {
    
    
    // MARK: - Outlets
    @IBOutlet weak var userListTableView: UITableView!
    
// MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserListViewModel(delegate: self)
        userListTableView.dataSource = self
        viewModel.loadUsers()
    }
    
    // MARK: - Properties
    var viewModel: UserListViewModel!

}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell()}
        
        let user = viewModel.users[indexPath.row]
        cell.updateUI(user: user)
        
        return cell
    }
    
    
}

extension UserListViewController: UserListViewModelDelegate {
    func usersLoadedSuccessfully() {
        self.userListTableView.reloadData()
    }
    
    
}
