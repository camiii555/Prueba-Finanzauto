//
//  BaseView.swift
//  Prueba Finanzauto
//
//  Created by Juan Camilo  Mejia Soto on 14/04/25.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 4
    }
}
