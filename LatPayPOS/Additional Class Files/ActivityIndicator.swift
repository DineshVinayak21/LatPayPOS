//
//  ActivityIndicator.swift
//  posTerminalApplication
//
//  Created by user166170 on 5/6/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit

class CommonActivityIndicator {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var elapsed = Double()
    
    //This functionis for automatic start and stopping the activity indicator
    func defaultActivityIndicator(uiView: UIView)
    {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
    
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
    
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
        
        let delay = max(0.0, 1.0 - elapsed)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay)
        {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
            self.activityIndicator.isHidden = true
        }
        
    }

    //This functionis for only starting the activity indicator
    func showActivityIndicator(uiView: UIView)
    {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
    
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
    
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    //This functionis for only stopping the activity indicator
    func hideActivityIndicator(uiView: UIView)
    {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

    //This function is for setting background overlay for activity indicator
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor
    {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
