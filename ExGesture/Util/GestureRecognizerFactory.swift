//
//  GestureRecognizerFactory.swift
//  ExGesture
//
//  Created by 강동영 on 7/21/24.
//

import UIKit

class GestureRecognizerFactory {
    static let shared: GestureRecognizerFactory = .init()
    private init() {
        print(#function)
    }
    
    deinit {
        print(#function)
    }
    
    func makeTapGesture(target: Any?, action: Selector) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: target, action: action)
        // 탭수
        tap.numberOfTapsRequired = 1
        // 손가락수
        tap.numberOfTouchesRequired = 1
        return tap
    }
    
    func makeLongPressGesture(target: Any?, action: Selector) -> UILongPressGestureRecognizer {
        let tap = UILongPressGestureRecognizer(target: target, action: action)
        tap.minimumPressDuration = 0.5
        tap.numberOfTapsRequired = 0
        tap.numberOfTouchesRequired = 1
        return tap
    }
    
    func makePanGesture(target: Any?, action: Selector) -> UIPanGestureRecognizer {
        let tap = UIPanGestureRecognizer(target: target, action: action)
        tap.minimumNumberOfTouches = 1
        tap.maximumNumberOfTouches = NSIntegerMax
        return tap
    }
    
    func makeSwipeGesture(target: Any?, action: Selector) -> UISwipeGestureRecognizer {
        let tap = UISwipeGestureRecognizer(target: target, action: action)
        // 손가락수
        tap.numberOfTouchesRequired = 1
        // 스와이프 방향
        tap.direction = .right
        return tap
    }
    
    func makePinchGesture(target: Any?, action: Selector) -> UIPinchGestureRecognizer {
        let tap = UIPinchGestureRecognizer(target: target, action: action)
        return tap
    }
    
    func makeRotationGesture(target: Any?, action: Selector) -> UIRotationGestureRecognizer {
        let tap = UIRotationGestureRecognizer(target: target, action: action)
        return tap
    }
}
