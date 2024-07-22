//
//  UILabelBuilder.swift
//  ExGesture
//
//  Created by 강동영 on 7/23/24.
//
import UIKit

class UILabelBuilder {
    private let label: UILabel = {
        let label: UILabel = .init(frame: CGRect(x: 30, y: 30, width: 150, height: 100))
        label.isUserInteractionEnabled = true
        return label
    }()
    
    func setFrame(frame: CGRect) -> UILabelBuilder {
        label.frame = frame
        return self
    }
    
    func setText(_ text: String) -> UILabelBuilder {
        label.text = text
        return self
    }
    
    func setBackgroundColor(_ color: UIColor) -> UILabelBuilder {
        label.backgroundColor = color
        return self
    }
    
    func addGestureRecognizer(_ gesture: UIGestureRecognizer) -> UILabelBuilder {
        label.addGestureRecognizer(gesture)
        return self
    }
    
    func build() -> UILabel {
        label.numberOfLines = 0
        return label
    }
}
