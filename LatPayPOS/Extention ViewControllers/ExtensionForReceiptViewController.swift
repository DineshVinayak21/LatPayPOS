//
//  ExtensionForReceiptViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ReceiptViewController
{
    func designFunctionRVC()
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

    }
    
    func fetchingReceiptDetails()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Receipt> = Receipt.fetchRequest()
        
        do
        {
            receipt = try managedContext.fetch(fetchRequest)
            receiptTableView.reloadData()
            print("Fetch Function Called Successfully")
            if self.receipt == []
            {
                noTransImage.isHidden = false
                receiptTableView.isHidden = true
            }
            else
            {
                noTransImage.isHidden = true
                receiptTableView.isHidden = false
                receiptTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func deleteReceipt(at indexPath: IndexPath)
    {
        let resc = receipt[indexPath.row]
        
        guard let managedContext = resc.managedObjectContext else {
            return
        }
        managedContext.delete(resc)
        do
        {
            try managedContext.save()
            receipt.remove(at: indexPath.row)
            receiptTableView.deleteRows(at: [indexPath], with: .automatic)
            fetchingReceiptDetails()
        }
        catch
        {
            print("Could Not Delete")
            receiptTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
