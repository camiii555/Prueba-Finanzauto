//
//  DeleteUserViewModel.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 15/04/25.
//

import Foundation

class DeleteUserViewModel {
    
    var onError: ((String) -> Void)?
    
    func deleteUser(idUser: String, completion: @escaping (Bool) -> Void) {
        
        guard let url = URL(string: "\(Constans.Requests.urlDeleteUser)\(idUser)") else {
            onError?("Unable to create URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constans.Requests.httpMethod.delete.rawValue
        request.setValue(Constans.Requests.appID, forHTTPHeaderField: "app-id")
        
        request.logRequest()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.onError?("Network error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.onError?("Unable to get server response")
                completion(false)
                return
            }
            
            if httpResponse.statusCode >= 400 {
                self.onError?("Server error, status code: \(httpResponse.statusCode)")
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 204 {
                print("User successfully deleted, status code: \(httpResponse.statusCode)")
                completion(true)
            } else {
                self.onError?("Error deleting user, status code: \(httpResponse.statusCode)")
                completion(false)
            }
        }
        
        task.resume()
    }
}

