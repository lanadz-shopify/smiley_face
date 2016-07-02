//
//  ViewController.swift
//  SmileView
//
//  Created by Svitlana Dzyuban on 15/6/16.
//  Copyright © 2016 Lana Dzyuban. All rights reserved.
//

import UIKit

class SmileViewController: UIViewController {
    var expression = FacialExpression(eyes: .Closed, brows: .Relaxed, mouth: .Neutral) {
        didSet { updateUI() }
    }

    @IBOutlet weak var faceView: FaceView! { didSet { updateUI() } }

    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyeOpen = true
        case .Closed: faceView.eyeOpen = false
        case .Squinting: faceView.eyeOpen = false
        }

        faceView.mouthCurvature = CGFloat(mouthCurvatures[expression.mouth] ?? 0.0 )
        faceView.eyeBrowTilt = CGFloat(browTilts[expression.brows] ?? 0.5)
    }

    private let mouthCurvatures = [ FacialExpression.Mouth.Frown: -1.0, .Grin: 0.5, .Smile: 1, .Smirk: -0.5 ]
    private let browTilts = [ FacialExpression.EyeBrows.Furrowed: -1.0, .Normal: 0.0, .Relaxed: 0.5 ]
}

