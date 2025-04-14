//
//  GetUserViewModel.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 15/04/25.
//

import Foundation

class GetUserViewModel {
    
    
    var onUserFetched: ((User) -> Void)?
    var onError: ((String) -> Void)?
    
    
    func fetchUser(withID userID: String) {
        let baseURL = Constans.Requests.baseURL
        guard let url = URL(string: baseURL + userID) else {
            onError?("invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Constans.Requests.httpMethod.get.rawValue
        request.setValue(Constans.Requests.appID, forHTTPHeaderField: "app-id")
        request.logRequest()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.onError?("Network Error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.onError?("No data received")
                }
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ [RESPONSE]\n\(responseString)")
            }

            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.onUserFetched?(user)
                }
            } catch {
                DispatchQueue.main.async {
                    self.onError?("Error decoding JSON: \(error.localizedDescription)")
                    print("❌ Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
}

