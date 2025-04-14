//
//  CreateUserResponse.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import Foundation

struct CreateUserResponse: Codable {
    var id, title, firstName, lastName: String?
    var picture, gender, email, dateOfBirth: String?
    var phone, registerDate, updatedDate: String?
    
    init(id: String? = nil, title: String? = nil, firstName: String? = nil, lastName: String? = nil, picture: String? = nil, gender: String? = nil, email: String? = nil, dateOfBirth: String? = nil, phone: String? = nil, registerDate: String? = nil, updatedDate: String? = nil) {
        self.id = id
        self.title = title
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.gender = gender
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.phone = phone
        self.registerDate = registerDate
        self.updatedDate = updatedDate
    }
}
