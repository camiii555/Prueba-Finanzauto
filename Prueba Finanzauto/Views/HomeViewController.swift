//
//  ViewController.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var userListTablaView: UITableView!
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Constans.NotificationName.reloadDataUserListNotificationName, object: nil)
    }
    
    private let userListViewModel = UsersListViewModel()
    private let deleteUserViewModel = DeleteUserViewModel()
    
    private var selectedId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: Constans.NotificationName.reloadDataUserListNotificationName, object: nil)
    }
    
    
    // MARK: - Private Methods
    private func setupTableView() {
        userListTablaView.delegate = self
        userListTablaView.dataSource = self
        registerCells()
    }
    
    private func registerCells() {
        userListTablaView.register(UINib(nibName: Constans.CellIdentifier.userListTableViewCell, bundle: nil), forCellReuseIdentifier: Constans.CellIdentifier.userListTableViewCell)
    }
    
    private func bindViewModel() {
        userListViewModel.fetchUsers { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async(execute: {
                self?.userListTablaView.reloadData()
            })
        }
    }
    
    
    private func deleteUser(id: String, at indexPath: IndexPath) {
        deleteUserViewModel.deleteUser(idUser: id) { [weak self] success in
            DispatchQueue.main.async(execute: {
                if success {
                    self?.userListViewModel.usersList.remove(at: indexPath.row)
                    self?.userListTablaView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    self?.showAlert(title: "Error", message: "No se puedo eliminar el usuario")
                }
            })
        }
    }
    
    // MARK: - Objc methos
    @objc func reloadData() {
        DispatchQueue.main.async(execute: {
            self.bindViewModel()
        })
    }
}

// MARK: - TableView Methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListViewModel.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.CellIdentifier.userListTableViewCell, for: indexPath) as? UserListTableViewCell else { return UITableViewCell() }
        
        let data = userListViewModel.usersList[indexPath.row]
        cell.delegate = self
        cell.userId = data.id
        cell.userName.text = (data.firstName ?? "") + " " + (data.lastName ?? "")
        cell.userID.text = "id: \(data.id ?? "")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] (_, _, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }
            guard let userId = self.userListViewModel.usersList[indexPath.row].id else { return }
            self.deleteUser(id: userId, at: indexPath)
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension HomeViewController: UserListTableViewCellDelegate {
    func goToDetailUser(userId: String) {
        selectedId = userId
        performSegue(withIdentifier: "userDetail", sender: nil)
    }
}

extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetail",
           let destinationVC = segue.destination as? UserDetailViewController {
            destinationVC.userId = selectedId
        }
    }
}
