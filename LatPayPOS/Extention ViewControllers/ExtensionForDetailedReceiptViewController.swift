//
//  ExtensionForDetailedReceiptViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
extension DetailedReceiptViewController
{
    func designFunctionDRVC()
    {
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
        
        backButtonLabel.layer.cornerRadius = 5
        insideView.layer.cornerRadius = 5
        sendReceipt.layer.cornerRadius = 5
            
        actualPrice.text = updateActualPrice + " $"
        couponName.text = "Coupon Name : " + updateCouponName
        couponPrice.text = "- " + updateCouponPrice + " $"
        dateTime.text = updateDateAndTime
        topFinalAmount.text = "$ " + updateReceiptPrice
        bottomFinalAmount.text = updateReceiptPrice
        numOfProducts.text = "No of Products : " + updateNumberOfProducts
        listOfProducts.text = updateProductsList
        
        couponName.textColor = UIColor.red
        couponPrice.textColor = UIColor.red
    }
}
