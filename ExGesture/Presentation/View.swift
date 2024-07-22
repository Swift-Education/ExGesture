//
//  View.swift
//  ExGesture
//
//  Created by 강동영 on 7/19/24.
//

import UIKit

final class View: UIView {
    private let factory: GestureRecognizerFactory = .shared
    private var initialCenter = CGPoint()  // 뷰의 최초 center 값

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .systemBackground
        
        let singleTap = factory.makeTapGesture(target: self, action: #selector(tapPiece(_:)))
        singleTap.delegate = self
        singleTap.name = "singleTap"
        let doubleTap = factory.makeTapGesture(target: self, action: #selector(tapPiece(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.name = "doubleTap"
        
        let tapView = UILabelBuilder()
            .setFrame(frame: CGRect(x: 30, y: 100, width: 150, height: 100))
            .setText("Try Single Tap Gesture")
            .setBackgroundColor(.systemPink)
            .addGestureRecognizer(singleTap)
            .addGestureRecognizer(doubleTap)
            .build()
        
        let longPressView = UILabelBuilder()
            .setFrame(frame: CGRect(x: 200, y: 100, width: 150, height: 100))
            .setText("Try Long-Press Gesture")
            .setBackgroundColor(.systemCyan)
            .addGestureRecognizer(factory.makeLongPressGesture(target: self, action: #selector(showResetMenu(_:))))
            .build()
        
        let panView = UILabelBuilder()
            .setFrame(frame: CGRect(x: 30, y: 600, width: 150, height: 100))
            .setText("Try Pan Gesture")
            .setBackgroundColor(.systemPink)
            .addGestureRecognizer(factory.makePanGesture(target: self, action: #selector(panPiece(_:))))
            .build()
        
        let pinchView = UILabelBuilder()
            .setFrame(frame: panView.frame)
            .setText("Try Pinch Gesture")
            .setBackgroundColor(.systemYellow)
            .addGestureRecognizer(factory.makePanGesture(target: self, action: #selector(panPiece(_:))))
            .addGestureRecognizer(factory.makePinchGesture(target: self, action: #selector(scalePiece(_:))))
            .build()
        
        
        let rotationView = UILabelBuilder()
            .setFrame(frame: panView.frame)
            .setText("Try rotation Gesture")
            .setBackgroundColor(.systemGreen)
            .addGestureRecognizer(factory.makePanGesture(target: self, action: #selector(panPiece(_:))))
            .addGestureRecognizer(factory.makeRotationGesture(target: self, action: #selector(rotatePiece(_:))))
            .build()
        
        let swipeView = UILabelBuilder()
            .setFrame(frame: panView.frame)
            .setText("Try swipe Gesture")
            .setBackgroundColor(.systemRed)
            .addGestureRecognizer(factory.makeSwipeGesture(target: self, action: #selector(swipeHandler(_:))))
            .build()
        
        addSubview(tapView)
        addSubview(longPressView)
        addSubview(swipeView)
        addSubview(panView)
        addSubview(pinchView)
        addSubview(rotationView)
    }
}

// MARK: - Action Method
extension View {
    @objc func tapPiece(_ gestureRecognizer : UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        let constant: CGFloat = gestureRecognizer.numberOfTapsRequired == 1 ? 10 : -10
        if gestureRecognizer.state == .ended {
            let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
                gestureRecognizer.view!.frame.size.width += constant
                gestureRecognizer.view!.frame.size.height += constant
            })
            animator.startAnimation()
        }
    }
    
    // MARK: - Long-press Gesture
    @objc func showResetMenu(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            self.becomeFirstResponder()
            
            // 뷰의 CGPoint 값을 받아올 수 있다.
            let location = gestureRecognizer.location(in: gestureRecognizer.view)
            
            // iOS16부터 사용 가능한 UIEditMenuInteraction
            let menuInteraction = UIEditMenuInteraction(delegate: self)
            gestureRecognizer.view?.addInteraction(menuInteraction)
            // location 위치에 Menu를 보여주는 메서드
            menuInteraction.presentEditMenu(with: UIEditMenuConfiguration(identifier: nil, sourcePoint: location))
        }
    }
    
    // MARK: - Pan Gesture
    @objc func panPiece(_ gestureRecognizer : UIPanGestureRecognizer) {
        print(#function)
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        
        // 1. translation(in:) 메서드를 통해서 원래 터치 위치에서 이동한 X, Y 거리를 얻을 수 있습니다.
        let translation = gestureRecognizer.translation(in: piece.superview)
        if gestureRecognizer.state == .began {
            // 2. 뷰의 원래 위치를 self.initialCenter 에 저장해줍니다.
            self.initialCenter = piece.center
        }
        // 3. .began, .changed, 그리고 .ended 상태에 대해서 위치를 업데이트 해줍니다.
        if gestureRecognizer.state != .cancelled {
            // 4. translation 변수를 통해 초기값 + 이동한 거리를 더해줍니다.
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            piece.center = newCenter
        }
        else {
            // 취소시 최초 위치로 돌아가게됩니다.
            piece.center = initialCenter
        }
    }
    
    // MARK: - Swipe Gesture
    @objc func swipeHandler(_ gestureRecognizer : UISwipeGestureRecognizer) {
        print(#function)
        guard gestureRecognizer.view != nil else {return}
        let piece = gestureRecognizer.view!
        let randomBackgroundColor: UIColor = [UIColor.systemCyan,
                                              .systemMint,
                                              .systemTeal,
                                              .systemBrown,
                                              .systemGray2].randomElement()!
        if gestureRecognizer.state == .ended {
            // 스와이프가 끝나면 랜덤으로 백그라운드 색상 교체
            piece.backgroundColor = randomBackgroundColor
        }
    }
    
    // MARK: - Pinch Gesture
    @objc func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {
        print(#function)
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = (gestureRecognizer.view?.transform.scaledBy(x: gestureRecognizer.scale,
                                                                                            y: gestureRecognizer.scale))!
            gestureRecognizer.scale = 1.0
        }
    }
    
    @objc func rotatePiece(_ gestureRecognizer : UIRotationGestureRecognizer) {
        print(#function)
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
            // 시간 흐름에 따라 선형적으로 증가하기에, rotation = 0 으로 초기화
            gestureRecognizer.rotation = 0
        }}
}

extension View: UIGestureRecognizerDelegate {
    // 인식되는 순서를 결정
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.name == "singleTap" && otherGestureRecognizer.name == "doubleTap" {
            return true
        }
        return false
    }
}

// MARK: - UIEditMenuInteractionDelegate Method
extension View: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
        let actions: [UIAction] = [.init(title: "Reset") { act in
            self.doSomething()
        }]
                                         
        let menu: UIMenu = .init(title: "menu",
                                 children: actions)

        return menu
    }
    
    private func doSomething() { print(#function) }
}
