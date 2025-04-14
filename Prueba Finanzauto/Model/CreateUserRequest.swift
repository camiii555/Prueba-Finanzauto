//
//  CreateUserRequest.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import Foundation

struct CreateUserRequest: Codable {
    var title, firstName, lastName, gender: String
    var email: String
    var dateOfBirth: String
    var phone, picture: String
    
    
    init(title: String, firstName: String, lastName: String, gender: String, email: String, dateOfBirth: String, phone: String, picture: String) {
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.picture = picture
    }
}
