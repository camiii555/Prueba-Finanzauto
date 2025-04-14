//
//  UserListTableViewCell.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

protocol UserListTableViewCellDelegate: AnyObject {
    func goToDetailUser(userId: String)
}

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userID: UILabel!
    
    var userId: String?
    
    weak var delegate: UserListTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func detailUserById(_ sender: Any) {
        guard let userId = userId else { return }
        delegate?.goToDetailUser(userId: userId)
    }
}
