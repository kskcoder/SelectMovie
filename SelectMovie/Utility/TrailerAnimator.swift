//
//  TrailerAnimator.swift
//  SelectMovie
//
//  Created by Tejas Kashid on 22/02/26.
//
import Foundation
import UIKit

class TrailerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        let container = transitionContext.containerView
        container.addSubview(toView)
        
        toView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 0.5, animations: {
            toView.alpha = 1
            toView.transform = .identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
