//
//  HideKeyboardExtension.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

extension UIViewController {
    func hidekeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dissmissKeyboard() {
        view.endEditing(true)
    }
}
