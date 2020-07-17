//
//  ExtentionForAddItemsViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit

extension AddItemsViewController
{
    func designFunctionAIVC()
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
        
        let lineView = UIView(frame: CGRect(x: 0, y: categoriesButtonLabel.frame.size.height, width: categoriesButtonLabel.frame.size.width, height: 2))
        lineView.backgroundColor = UIColor.lightGray
        categoriesButtonLabel.addSubview(lineView)
        
        let lineView1 = UIView(frame: CGRect(x: 0, y: productsButtonLabel.frame.size.height, width: productsButtonLabel.frame.size.width, height: 2))
        lineView1.backgroundColor = UIColor.lightGray
        productsButtonLabel.addSubview(lineView1)
        
        let lineView2 = UIView(frame: CGRect(x: 0, y: discontButtonLabel.frame.size.height, width: discontButtonLabel.frame.size.width, height: 2))
        lineView2.backgroundColor = UIColor.lightGray
        discontButtonLabel.addSubview(lineView2)
        
        let lineView3 = UIView(frame: CGRect(x: 0, y: flatPriceButtonLabel.frame.size.height, width: flatPriceButtonLabel.frame.size.width, height: 2))
        lineView3.backgroundColor = UIColor.lightGray
        flatPriceButtonLabel.addSubview(lineView3)
    }
}
