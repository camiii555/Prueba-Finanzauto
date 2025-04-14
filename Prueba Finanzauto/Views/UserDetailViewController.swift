//
//  UserDetailViewController.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 15/04/25.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var userDetailTableView: UITableView!
    
    private let getUserViewModel = GetUserViewModel()
    
    var userId: String?
    
    private var userData: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupTableView()
    }
    
    private func setupTableView() {
        userDetailTableView.delegate = self
        userDetailTableView.dataSource = self
        userDetailTableView.register(UINib(nibName: Constans.CellIdentifier.formRegisterUserTableViewCell, bundle: nil), forCellReuseIdentifier: Constans.CellIdentifier.formRegisterUserTableViewCell)
    }
    
    private func bindViewModel() {
        
        guard let userId = userId else { return }
        
        getUserViewModel.onUserFetched = { [weak self] user in
            self?.userData = user
            self?.userDetailTableView.reloadData()
        }
        
        getUserViewModel.fetchUser(withID: userId)
    }
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.CellIdentifier.formRegisterUserTableViewCell, for: indexPath) as? FormRegisterUserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.cancelButton.isHidden = true
        cell.saveOrCreateUserButton.isHidden = true
        cell.idTextField.text = userData?.id ?? ""
        cell.titleTextField.text = userData?.title ?? ""
        cell.nameTextField.text = userData?.firstName ?? ""
        cell.lastNameTextField.text = userData?.lastName ?? ""
        cell.genderTextField.text = userData?.gender ?? ""
        cell.emailTextField.text = userData?.email ?? ""
        cell.birthDateTextField.text = userData?.dateOfBirth ?? ""
        cell.phoneTextField.text = userData?.phone ?? ""
        
        return cell
    }
    
    
}
