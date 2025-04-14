//
//  RegisterUserViewController.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

class RegisterUserViewController: BaseViewController {

    @IBOutlet weak var registerUserTableView: UITableView!
    
    private var viewModel: CreateUserViewModel = CreateUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    
    private func setupTableView() {
        registerUserTableView.delegate = self
        registerUserTableView.dataSource = self
        registerUserTableView.register(UINib(nibName:Constans.CellIdentifier.formRegisterUserTableViewCell , bundle: nil), forCellReuseIdentifier: Constans.CellIdentifier.formRegisterUserTableViewCell)
    }
    
    
    private func alertByResponse(title: String, message: String) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        })
    }
    
}

extension RegisterUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.CellIdentifier.formRegisterUserTableViewCell, for: indexPath) as? FormRegisterUserTableViewCell else { return UITableViewCell() }
        cell.idTextField.isEnabled = false
        cell.delegate = self
        
        return cell
    }
    
}

extension RegisterUserViewController: FormRegisterTableViewCellDelegate {
    func formRegisterTableViewCellDidTapNext(userCreate: CreateUserRequest) {
        viewModel.registerUser(newUSer: userCreate) { success, dataResponse in
            if success {
                self.alertByResponse(title: "Usuario Creado Correctamente", message: dataResponse?.id ?? "")
            } else {
                self.alertByResponse(title: "Error", message: "No se puedo registarar el usuario")
            }
        }
    }
}
