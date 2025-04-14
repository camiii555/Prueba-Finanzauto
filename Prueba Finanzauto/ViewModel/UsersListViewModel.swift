//
//  ViewModel.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import Foundation

class UsersListViewModel {
    
    var usersList: [User] = []
    var OnError: ((String) -> Void)?
    
    func fetchUsers(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: Constans.Requests.urlUserList) else {
            OnError?("Unable to create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constans.Requests.httpMethod.get.rawValue
        request.setValue(Constans.Requests.appID, forHTTPHeaderField: "app-id")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.logRequest()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(false)
                    self.OnError?("Network error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false)
                    self.OnError?("No data received")
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ [RESPONSE]\n\(responseString)")
            }
            
            do {
                let decodedUserList = try JSONDecoder().decode(UsersListModel.self, from: data)
                self.usersList = decodedUserList.data ?? []
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false)
                    self.OnError?("Error decoding JSON: \(error.localizedDescription)")
                    print("❌ Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}


