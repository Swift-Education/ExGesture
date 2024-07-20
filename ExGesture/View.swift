//
//  View.swift
//  ExGesture
//
//  Created by 강동영 on 7/19/24.
//

import UIKit

final class View: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    init(frame: CGRect, gesture: UIGestureRecognizer) {
        super.init(frame: frame)
        
        addGestureRecognizer(gesture)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .systemBackground
}
