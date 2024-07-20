//
//  GestureRecognizerBuilder.swift
//  ExGesture
//
//  Created by 강동영 on 7/19/24.
//

import UIKit

class GestureRecognizerBuilder {
    private let gesture: UIGestureRecognizer!
    private let target: Any?
    static func selectGesture(type: Gesture, target: Any?) -> GestureRecognizerBuilder {
        return GestureRecognizerBuilder(type: type, target: target)
    }
    
    init(type: Gesture, target: Any?) {
        self.gesture = UITapGestureRecognizer()
        self.target = target
    }
    
    func build() -> UIGestureRecognizer {
        gesture.addTarget(target!, action: #selector(tapPiece(_:)))
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapPiece(_:)))
        return gesture
    }
    
    @objc func tapPiece(_ gestureRecognizer : UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
            let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
                gestureRecognizer.view!.center.x += 100
                gestureRecognizer.view!.center.y += 100
            })
            animator.startAnimation()
        }
    }
}

