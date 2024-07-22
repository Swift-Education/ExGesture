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
        print(#function)
        let tap = UITapGestureRecognizer(target: target, action: action)
        // 탭수
        tap.numberOfTapsRequired = 1
        // 손가락수
        tap.numberOfTouchesRequired = 1
        return tap
    }
    
    func makeLongPressGesture(target: Any?, action: Selector) -> UILongPressGestureRecognizer {
        print(#function)
        let tap = UILongPressGestureRecognizer(target: target, action: action)
        tap.minimumPressDuration = 0.5
        tap.numberOfTapsRequired = 0
        tap.numberOfTouchesRequired = 1
        return tap
    }
    
    func makePanGesture(target: Any?, action: Selector) -> UIPanGestureRecognizer {
        print(#function)
        let tap = UIPanGestureRecognizer(target: target, action: action)
        tap.minimumNumberOfTouches = 1
        tap.maximumNumberOfTouches = NSIntegerMax
        return tap
    }
    
    func makeSwipeGesture(target: Any?, action: Selector) -> UISwipeGestureRecognizer {
        print(#function)
        let tap = UISwipeGestureRecognizer(target: target, action: action)
        // 손가락수
        tap.numberOfTouchesRequired = 1
        // 스와이프 방향
        tap.direction = .right
        return tap
    }
    
    func makePinchGesture(target: Any?, action: Selector) -> UIPinchGestureRecognizer {
        print(#function)
        let tap = UIPinchGestureRecognizer(target: target, action: action)
        return tap
    }
    
    func makeRotationGesture(target: Any?, action: Selector) -> UIRotationGestureRecognizer {
        print(#function)
        let tap = UIRotationGestureRecognizer(target: target, action: action)
        return tap
    }
}
