//
//  ExtensionForApplyCouponViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/16/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ApplyCouponViewController
{
    func designFunctionACVC()
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

    }
    
    func loadingDiscountAtInitial()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Discounts> = Discounts.fetchRequest()
        
        do
        {
            discount = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            applyCoupon.reloadData()
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func loadingFlatPriceAtInitial()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<FlatPrice> = FlatPrice.fetchRequest()
        
        do
        {
            flatPrice = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            applyCoupon.reloadData()
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func validation()
    {
        if self.discount == [] && self.flatPrice == []
        {
            applyCoupon.isHidden = true
        }
        else
        {
            applyCoupon.isHidden = false
        }
    }
    
    func couponAppliedAlert()
    {
        let alert = UIAlertController(title: "Coupon Applied", message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func couponCantAppliedAlert()
    {
        let alert = UIAlertController(title: "Oops!!", message: "Discount exceed than Actual Price", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
