//
//  EmotionsViewController.swift
//  SmileView
//
//  Created by Svitlana Dzyuban on 6/7/16.
//  Copyright © 2016 Lana Dzyuban. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    private let faceEmotions: Dictionary<String, FacialExpression> = [
        "angry": FacialExpression(eyes: .Closed, brows: .Furrowed, mouth: .Frown),
        "mischievious": FacialExpression(eyes: .Open, brows: .Furrowed, mouth: .Grin),
        "happy": FacialExpression(eyes: .Open, brows: .Normal, mouth: .Smile),
        "sad": FacialExpression(eyes: .Open, brows: .Relaxed, mouth: .Frown),
        "worried": FacialExpression(eyes: .Open, brows: .Relaxed, mouth: .Neutral)

    ]
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destinationvc = segue.destinationViewController

        if let navvc = destinationvc as? UINavigationController {
            destinationvc = navvc.visibleViewController ?? destinationvc
        }

        if let facevc = destinationvc as? SmileViewController {
            if let identifier = segue.identifier {
                if let expression = faceEmotions[identifier]{
                    facevc.expression = expression
                    if let senderButton = sender as? UIButton {
                        facevc.navigationItem.title = senderButton.currentTitle
                    }
                }
            }
        }
    }
}
