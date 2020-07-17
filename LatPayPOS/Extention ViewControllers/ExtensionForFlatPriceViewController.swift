//
//  ExtensionForFlatPriceViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension FlatPriceViewController
{
    func designFunctionFPVC()
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
    
    func showFlatPriceAtInitial()
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
            flatPriceTable.reloadData()
            print("Fetch Function Called Successfully")
            if self.flatPrice == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                flatPriceTable.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                flatPriceTable.isHidden = false
                flatPriceTable.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func deleteFlatPrice(at indexPath: IndexPath)
    {
        let fprice = flatPrice[indexPath.row]
        
        guard let managedContext = fprice.managedObjectContext else {
            return
        }
        managedContext.delete(fprice)
        do
        {
            try managedContext.save()
            flatPrice.remove(at: indexPath.row)
            flatPriceTable.deleteRows(at: [indexPath], with: .automatic)
            reloadFlatPriceListAgain()
        }
        catch
        {
            print("Could Not Delete")
            flatPriceTable.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func reloadFlatPriceListAgain()
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
            flatPriceTable.reloadData()
            print("Fetch Function Called Successfully")
            if self.flatPrice == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                flatPriceTable.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                flatPriceTable.isHidden = false
                flatPriceTable.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
}
