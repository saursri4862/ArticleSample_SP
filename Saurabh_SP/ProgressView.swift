//
//  ProgressView.swift
//  Saurabh_SP
//
//  Created by saurabh srivastava on 04/08/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

open class ProgressView {
    static let shared = ProgressView()
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    open func showProgressView() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        containerView.frame = window.frame
        containerView.center = window.center
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = window.center
        progressView.backgroundColor = UIColor.clear
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        UIApplication.shared.keyWindow?.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
extension UIViewController {
    
    func showAlert(_ title: String?, message: String? , viewController:UIViewController? = nil) {
        
        DispatchQueue.main.async { () -> Void in
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Ok"), style: UIAlertActionStyle.default, handler: nil))
            
            if viewController != nil {
                let hostVC = viewController
                hostVC?.present(alert, animated: true, completion: nil)
            }
            else {
                var hostVC = self.view.window?.rootViewController
                while let next = hostVC?.presentedViewController {
                    hostVC = next
                }
                
                hostVC?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
