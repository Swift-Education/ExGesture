//
//  ViewController.swift
//  ExGesture
//
//  Created by 강동영 on 7/18/24.
//

import UIKit

final class ViewController: UIViewController {
    private var gestureBuilder: GestureRecognizerBuilder!
    
    override func loadView() {
        super.loadView()
        
        gestureBuilder = GestureRecognizerBuilder
                      .makeGesture(type: .tap)
        let gesture = gestureBuilder.build()
        view = View(frame: view.bounds, gesture: gesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

