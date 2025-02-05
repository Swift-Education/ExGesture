//
//  DrawLineViewController.swift
//  ExGesture
//
//  Created by 강동영 on 2/5/25.
//

import UIKit

// Implementing coalesced touch support in an app - apple doc
// https://developer.apple.com/documentation/uikit/implementing-coalesced-touch-support-in-an-app

final class DrawLineViewController: UIViewController {
    private let drawingView = DrawingView(strokeCollection: StrokeCollection())
    override func loadView() {
        
        view = drawingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.setRightBarButton(
            UIBarButtonItem(title: "Clear",
                            image: nil,
                            target: self,
                            action: #selector(clearCanvas)),
            animated: false
        )
    }
    
    @objc private func clearCanvas() {
        drawingView.clear()
    }
}

fileprivate class Stroke {
    var samples = [StrokeSample]()
    func add(sample: StrokeSample) {
        samples.append(sample)
    }
}

fileprivate struct StrokeSample {
    let location: CGPoint
    let coalescedSample: Bool
    init(point: CGPoint, coalesced : Bool = false) {
        location = point
        coalescedSample = coalesced
    }
}

fileprivate class StrokeCollection {
    var strokes = [Stroke]()
    var activeStroke: Stroke? = nil
    
    func acceptActiveStroke() {
        if let stroke = activeStroke {
            strokes.append(stroke)
            activeStroke = nil
        }
    }
}

fileprivate class DrawingView : UIView {
    private var path = UIBezierPath()
    private var strokeCollection: StrokeCollection? {
        didSet {
            // If the strokes change, redraw the view's content.
            if oldValue !== strokeCollection {
                path.removeAllPoints()
                setNeedsDisplay()
            }
        }
    }
    
    // Initialization methods...
    init(strokeCollection: StrokeCollection? = nil) {
        self.strokeCollection = strokeCollection
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.label.setStroke()
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        path.stroke()
    }
    
    func clear() {
        strokeCollection = StrokeCollection()
    }
    
    // Touch Handling methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Create a new stroke and make it the active stroke.
        let newStroke = Stroke()
        strokeCollection?.activeStroke = newStroke
        
        // The view does not support multitouch, so get the samples
        //  for only the first touch in the event.
        if let coalesced = event?.coalescedTouches(for: touches.first!) {
            addSamples(for: coalesced)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let coalesced = event?.coalescedTouches(for: touches.first!) {
            addSamples(for: coalesced)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Accept the current stroke and add it to the stroke collection.
        if let coalesced = event?.coalescedTouches(for: touches.first!) {
            addSamples(for: coalesced)
        }
        // Accept the active stroke.
        strokeCollection?.acceptActiveStroke()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Clear the last stroke.
        strokeCollection?.activeStroke = nil
    }
    
    func addSamples(for touches: [UITouch]) {
        if let stroke = strokeCollection?.activeStroke {
            // Add all of the touches to the active stroke.
            for touch in touches {
                if touch == touches.last {
                    let sample = StrokeSample(point: touch.preciseLocation(in: self))
                    stroke.add(sample: sample)
                } else {
                    // If the touch is not the last one in the array,
                    //  it was a coalesced touch.
                    let sample = StrokeSample(point: touch.preciseLocation(in: self),
                                              coalesced: true)
                    stroke.add(sample: sample)
                }
            }
            // Update the view.
            updatePath()
            self.setNeedsDisplay()
        }
    }
    
    private func updatePath() {
        guard strokeCollection != nil else { return }
        
        path.removeAllPoints()
        for stroke in strokeCollection!.strokes {
            if let firstSample = stroke.samples.first {
                path.move(to: firstSample.location)
            }
            for sample in stroke.samples.dropFirst() {
                path.addLine(to: sample.location)
            }
        }
        
        if let activeStroke = strokeCollection!.activeStroke {
            if let firstSample = activeStroke.samples.first {
                path.move(to: firstSample.location)
            }
            for sample in activeStroke.samples.dropFirst() {
                path.addLine(to: sample.location)
            }
        }
    }

}
