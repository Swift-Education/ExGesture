//
//  AdditiveColorViewController.swift
//  ExGesture
//
//  Created by 강동영 on 1/23/25.
//

import UIKit

final class AdditiveColorViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
    }
    
    private func layout() {
        // 배경색: 검정색 (어두운 배경)
        view.backgroundColor = .black
        let width: CGFloat = 200
        let height: CGFloat = 200
        // 빨강, 초록, 파랑 "빛"을 나타낼 뷰
        let redLight = createLightView(color: UIColor.red.withAlphaComponent(1.0), frame: CGRect(x: view.center.x - width / 2, y: 200, width: width, height: height))
        let greenLight = createLightView(color: UIColor.green.withAlphaComponent(1.0), frame: CGRect(x: view.center.x - width + 30, y: 300, width: width, height: height))
        let blueLight = createLightView(color: UIColor.blue.withAlphaComponent(1.0), frame: CGRect(x: view.center.x - 30, y: 300, width: width, height: height))
        
        
        // 뷰를 화면에 추가
        view.addSubview(redLight)
        view.addSubview(greenLight)
        view.addSubview(blueLight)
    }
    
    // "빛"을 나타내는 뷰 생성
    private func createLightView(color: UIColor, frame: CGRect) -> UIView {
        let lightView = UIView(frame: frame)
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panColorView))
        lightView.addGestureRecognizer(panGestureRecognizer)
        lightView.backgroundColor = color
        lightView.layer.compositingFilter = "screenBlendMode"
        lightView.layer.cornerRadius = frame.width / 2 // 원 모양
        lightView.clipsToBounds = true
        return lightView
    }
    
    @objc private func panColorView(_ recognizer: UIPanGestureRecognizer) {
        guard let targetView = recognizer.view else { return }
        
        let transition = recognizer.translation(in: targetView)
        
        targetView.center = CGPoint(x: targetView.center.x + transition.x, y: targetView.center.y + transition.y)
        recognizer.setTranslation(.zero, in: view)
    }
}
