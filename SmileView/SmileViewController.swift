//
//  ViewController.swift
//  SmileView
//
//  Created by Svitlana Dzyuban on 15/6/16.
//  Copyright © 2016 Lana Dzyuban. All rights reserved.
//

import UIKit

class SmileViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(
                UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))
                ))

            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self,
                action: #selector(SmileViewController.increaseHappiness)
            )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)

            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(
                target: self,
                action: #selector(SmileViewController.decreaseHappiness)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)

            updateUI()
        }
    }
    @IBAction func toggleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended{
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            default: break
            }
        }
    }


    var expression = FacialExpression(eyes: .Closed, brows: .Relaxed, mouth: .Neutral) {
        didSet { updateUI() }
    }

    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }

    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }

    private func updateUI() {
        if faceView != nil {
            switch expression.eyes {
            case .Open: faceView.eyeOpen = true
            case .Closed: faceView.eyeOpen = false
            case .Squinting: faceView.eyeOpen = false
            }

            faceView.mouthCurvature = CGFloat(mouthCurvatures[expression.mouth] ?? 0.0 )
            faceView.eyeBrowTilt = CGFloat(browTilts[expression.brows] ?? 0.5)
        }
    }

    private let mouthCurvatures = [ FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1, .Smirk: -0.5 ]
    private let browTilts = [ FacialExpression.EyeBrows.Furrowed: -1.0, .Normal: 0.0, .Relaxed: 0.5 ]
}

