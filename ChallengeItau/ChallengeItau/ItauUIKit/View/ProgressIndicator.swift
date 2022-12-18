//
//  ProgressIndicator.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit

protocol ViewInterface: AnyObject {
    func fullScreenLoading(hide: Bool)
    func fullScreenLoading(hide: Bool, height: CGFloat?)
}

extension ViewInterface where Self: UIViewController {
    
    func fullScreenLoading(hide: Bool) {
        DispatchQueue.main.async {
            self.fullScreenLoading(hide: hide, height: nil)
        }
    }
    
    func fullScreenLoading(hide: Bool, height: CGFloat?) {
        let tag = 99
        if hide {
            for views in self.view.subviews where views.tag == tag {
                for activity in views.subviews where activity is UIActivityIndicatorView {
                    views.removeFromSuperview()
                }
            }
        } else {
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = height ?? screenSize.height
            let view = UIView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight))
            view.backgroundColor = UIColor.white
            view.tag = tag
            
            let activityIndicator = UIActivityIndicatorView()
            
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            
            activityIndicator.center =  view.center
            
            self.view.addSubview(view)
        }
    }
}

