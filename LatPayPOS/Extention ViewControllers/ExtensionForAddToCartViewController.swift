//
//  ExtensionForAddToCartViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit

extension AddToCartViewController
{
    func frontDesignView()
    {
        //Design Constraints for Top Layer
        let shadowPath = UIBezierPath()
        let shadowWidth : CGFloat = 1.5
        let shadowHeight : CGFloat = 0.0
        let shadowRadious : CGFloat = 2
        
        let width = topView.frame.width
        let height = topView.frame.height
        
        shadowPath.move(to: CGPoint(x: shadowRadious/2, y: height - shadowRadious/2))
        shadowPath.addLine(to: CGPoint(x: width - shadowRadious / 2, y: height - shadowRadious / 2))
        shadowPath.addLine(to: CGPoint(x: width * shadowWidth, y: height + (height * shadowHeight)))
        shadowPath.addLine(to: CGPoint(x: width * -(shadowWidth - 1), y: height + (height * shadowHeight)))
        
        topView.layer.shadowPath = shadowPath.cgPath
        topView.layer.shadowRadius = shadowRadious
        topView.layer.shadowOffset = .zero
        topView.layer.shadowOpacity = 0.5
        
        backLabel.layer.cornerRadius = 5
        placeOrdelLabel.layer.cornerRadius = 5
        applyCouponButtonLabel.layer.cornerRadius = 5
        applyCouponButtonLabel.setTitle("Apply Coupon", for: .normal)
    }
    
    func tapCardActivity()
    {
        let alert = UIAlertController(title: nil, message: "Please Tap a Card", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        //loadingIndicator.startAnimating();
        let delay = 5 // seconds
        self.loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "bill", sender: self)
        }
    }
    
    func detectingDiscount()
    {
        temp = Double(totalPriceLbl.text!)!
        let temp1 = Double(tempDPercentage)
        let temp2 = Double(tempDPrice)
        
        let final = (temp/100) * temp1!
        if Int(final) > Int(temp2!)
        {
            print("Value Exceed the Maximum offer price")
            totalPriceLbl.text = String(temp - temp2!)
            discountedPriceHere = temp2!
        }
        else
        {
            print("Value not exceed maximum offer price")
            totalPriceLbl.text = String(temp - final)
            discountedPriceHere = final
        }
    }
    
    func detectingFlatPrice()
    {
        temp = Double(totalPriceLbl.text!)!
        let temp1 = Double(tempDPrice)
        let final = temp - temp1!
        totalPriceLbl.text = String(final)
        discountedPriceHere = temp1!
    }

}
