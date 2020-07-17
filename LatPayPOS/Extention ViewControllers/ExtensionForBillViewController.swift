//
//  ExtensionForBillViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension BillViewController
{
    func designFunctionBVC()
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
        
        doneButtonLabel.layer.cornerRadius = 5
    }
    
    func savingValuesToReciptDataBase()
    {
        //Checking Prpare For Segue Values
        print("currentDateTime :", currentDateTime)
        print("totalPrice :", totalPrice)
        print("numberOfProducts :", numberOfProducts)
        print("productList :", productList)
        print("couponName :", couponName)
        print("couponPrice :", couponPrice)
        print("actualPrice :", actualPrice)
        print("singleProductPrice :", singleProductPrice)
        
        let receiptClass = Receipt(productName: productList, singleProductPrice: singleProductPrice, totalCount: numberOfProducts, finalPrice: totalPrice, date: currentDateTime, couponName: couponName, discountedPrice: couponPrice, calculatedPrice: actualPrice)
        do
        {
            try receiptClass?.managedObjectContext?.save()
            print("Receipt Saved Successfully")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadReceiptVC"), object: nil)
        }
        catch
        {
            print("Could Not Save Products")
        }
    }
}
