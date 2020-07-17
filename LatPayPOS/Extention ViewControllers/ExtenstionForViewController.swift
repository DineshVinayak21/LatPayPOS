//
//  ExtenstionForViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ViewController: UISearchDisplayDelegate, UISearchBarDelegate
{
    func designFunctionVC()
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
            
        bottomLeftView.layer.cornerRadius = 5
        bottomRightView.layer.cornerRadius = 5
        gotoCartButtonLabel.layer.cornerRadius = 5
        bottomRightView.isHidden = true
        countLabel.text = "0"
        search.delegate = self

    }
    
    func loadingItemsAtBeginning()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        do
        {
            products = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            if self.products == []
            {
                print("No Product is Available in Store")
                insideView.layer.isHidden = false
                listView.layer.isHidden = true
                selectionView.layer.isHidden = true
                cartView.layer.isHidden = true
            }
            else
            {
                insideView.layer.isHidden = true
                listView.layer.isHidden = false
                selectionView.layer.isHidden = false
                cartView.layer.isHidden = false
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func loadingItemsAtMid()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
        
        do
        {
            products = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
          /*  if self.products == []
            {
                print("No Product is Available to Store")
                noItemImage.isHidden = false
                itemsDisplay.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                itemsDisplay.isHidden = false
                itemsDisplay.reloadData()
            } */
            if self.products == []
            {
                print("No Product is Available in Store")
                insideView.layer.isHidden = false
                listView.layer.isHidden = true
                selectionView.layer.isHidden = true
                cartView.layer.isHidden = true
            }
            else
            {
                insideView.layer.isHidden = true
                listView.layer.isHidden = false
                selectionView.layer.isHidden = false
                cartView.layer.isHidden = false
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
/*        if searchText != ""
        {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "name")
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
            fetchRequest.predicate = predicate
            do
            {
                products = try managedContext.fetch(fetchRequest)
            }
            catch
            {
                print("Could Not Get Datas")
            }
        }
        else
        {
            //loadingItemsAtMid()
            itemsDisplay.reloadData()
        }
        itemsDisplay.reloadData()*/
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//let managedContext = appDelegate.persistentContainer.viewContext
//let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
