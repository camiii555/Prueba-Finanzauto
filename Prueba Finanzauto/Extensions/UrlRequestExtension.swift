//
//  Untitled.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 15/04/25.

import Foundation

extension URLRequest {
    func logRequest() {
        print("➡️ [REQUEST] \(self.httpMethod ?? "") \(self.url?.absoluteString ?? "")")
        
        if let headers = self.allHTTPHeaderFields {
            print("Headers:")
            for (key, value) in headers {
                print("  \(key): \(value)")
            }
        }
        
        if let body = self.httpBody, !body.isEmpty {
            if let bodyString = String(data: body, encoding: .utf8) {
                print("Body:\n\(bodyString)")
            } else {
                print("Body: [Could not decode body in UTF-8]")
            }
        } else {
            print("Body: [Empty or not available]")
        }
    }
}


