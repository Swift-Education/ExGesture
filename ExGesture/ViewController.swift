//
//  ViewController.swift
//  ExGesture
//
//  Created by 강동영 on 7/18/24.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @objc func tapPiece(_ gestureRecognizer : UITapGestureRecognizer ) {
       guard gestureRecognizer.view != nil else { return }
            
       if gestureRecognizer.state == .ended {      // Move the view down and to the right when tapped.
          let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut, animations: {
             gestureRecognizer.view!.center.x += 100
             gestureRecognizer.view!.center.y += 100
          })
          animator.startAnimation()
       }}
}

