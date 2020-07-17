//
//  ExtensionForDiscountViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension DiscountsViewController
{
    func designFunctionDVC()
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
        
        addButtonlabel.layer.cornerRadius = 10
        addButtonlabel.layer.shadowColor = UIColor.black.cgColor
        addButtonlabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        addButtonlabel.layer.shadowRadius = 5
        addButtonlabel.layer.shadowOpacity = 1.0
        backButtonLabel.layer.cornerRadius = 5
    }
    
    func showDiscountAtInitial()
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
            discountTableView.reloadData()
            print("Fetch Function Called Successfully")
            if self.discount == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                discountTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                discountTableView.isHidden = false
                discountTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    
    func deleteDiscount(at indexPath: IndexPath)
    {
        let disc = discount[indexPath.row]
        
        guard let managedContext = disc.managedObjectContext else {
            return
        }
        managedContext.delete(disc)
        do
        {
            try managedContext.save()
            discount.remove(at: indexPath.row)
            discountTableView.deleteRows(at: [indexPath], with: .automatic)
            reloadDiscountListAgain()
        }
        catch
        {
            print("Could Not Delete")
            discountTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func reloadDiscountListAgain()
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
            discountTableView.reloadData()
            print("Fetch Function Called Successfully")
            if self.discount == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                discountTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                discountTableView.isHidden = false
                discountTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
}
