//
//  Constans.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import Foundation


struct Constans {
    
    struct CellIdentifier {
        static let userListTableViewCell = "UserListTableViewCell"
        static let formRegisterUserTableViewCell = "FormRegisterUserTableViewCell"
    }
    
    struct OptionsTextField {
        static let titleOptions = ["", "Señor", "Señora", "Señora - casada", "Señorita", "Doctor/Doctora"]
        static let genderOptions = ["", "Masculino", "Femenino", "Otro"]
        
    }
    
    struct FormValidation  {
        static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    }
    
    struct NotificationName {
        static let reloadDataUserListNotificationName = Notification.Name("reloadDataUserListNotificationName")
    }
    
    struct Requests {
        static let appID = "63473330c1927d386ca6a3a5"
        static let baseURL = "https://dummyapi.io/data/v1/user/"
        static let urlUserList = "https://dummyapi.io/data/v1/user?page=&imit="
        static let urlCreateUser = "https://dummyapi.io/data/v1/user/create"
        static let urlDeleteUser = "https://dummyapi.io/data/v1/user/"
        
        enum httpMethod: String {
            case get = "GET"
            case post = "POST"
            case put = "PUT"
            case delete = "DELETE"
        }
    }
    

}

