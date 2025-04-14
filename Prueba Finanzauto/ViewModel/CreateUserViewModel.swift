//
//  CreateUserViewModel.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import Foundation


class CreateUserViewModel {
    
    var OnError: ((String) -> Void)?
    
    func registerUser(newUSer: CreateUserRequest, completion: @escaping (Bool, CreateUserResponse?) -> Void) {
        guard let url = URL(string: Constans.Requests.urlCreateUser) else {
            OnError?("Unable to create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constans.Requests.httpMethod.post.rawValue
        request.setValue(Constans.Requests.appID, forHTTPHeaderField: "app-id")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // fixed
        
        do {
            let jsonData = try JSONEncoder().encode(newUSer)
            request.httpBody = jsonData
            
            request.logRequest()
            
        } catch {
            print("❌ Error encoding JSON: \(error.localizedDescription)")
            completion(false, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, nil)
                self.OnError?("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(false, nil)
                self.OnError?("No data received")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ [RESPONSE]\n\(responseString)")
            }
            
            do {
                let response = try JSONDecoder().decode(CreateUserResponse.self, from: data)
                completion(true, response)
                NotificationCenter.default.post(name: Constans.NotificationName.reloadDataUserListNotificationName, object: nil)
            } catch {
                self.OnError?("Error decoding JSON: \(error.localizedDescription)")
                print("❌ Error decoding JSON: \(error.localizedDescription)")
                completion(false, nil)
            }
        }
        
        task.resume()
    }
}
