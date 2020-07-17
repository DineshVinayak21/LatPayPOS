//
//  ExtensionForCategoriesViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension CategoriesViewController
{
    func designFunctionCVC()
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
    
    func showCategoryAtInitial()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do
        {
            categories = try managedContext.fetch(fetchRequest)
            categoryTableView.reloadData()
            print("Fetch Function Called Successfully")
            if self.categories == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                categoryTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                categoryTableView.isHidden = false
                categoryTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func loadProductAtInitial()
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
                print("No Product is Available to Store")
            }
            else
            {
                for temp in products as [NSManagedObject]
                {
                    listOfAvailableProductsAtInitial.append((temp.value(forKey: "mainCategory") as! String))
                }
                print("List of Categories Are: ", listOfAvailableProductsAtInitial)
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func addCategory()
    {
        let alertController = UIAlertController(title: "Enter Category Name", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                
                if text == ""
                {
                    print("Enter Valid Category name")
                }
                
                else {
                let category = Categories(title: text)
                do
                {
                    try category?.managedObjectContext?.save()
                }
                catch
                {
                    print("Could Not Save Category")
                }
                print("Text==>" + text)
                
                //Fetching
                
                self.reloadCategoryListAgain()
                
                //End Fetching
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Category Name"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadCategoryListAgain()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else
        {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Categories> = Categories.fetchRequest()
        
        do
        {
            categories = try managedContext.fetch(fetchRequest)
            categoryTableView.reloadData()
            print("Fetch Function Called Successfully")
            if self.categories == []
            {
                //noCategoryFoundAlert()
                noItemImage.isHidden = false
                categoryTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                categoryTableView.isHidden = false
                categoryTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func deleteCategory(at indexPath: IndexPath)
    {
        let cate = categories[indexPath.row]
        if listOfAvailableProductsAtInitial.contains(cate.title!)
        {
            print("Initial unable to Delete Option Runs")
            unableToDelete()
        }
        else
        {
            guard let managedContext = cate.managedObjectContext else { return }
            managedContext.delete(cate)
            do
            {
                try managedContext.save()
                categories.remove(at: indexPath.row)
                categoryTableView.deleteRows(at: [indexPath], with: .automatic)
                reloadCategoryListAgain()
            }
            catch
            {
                print("Could Not Delete")
                categoryTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
    
    func unableToDelete()
    {
        let alert = UIAlertController(title: "Unable To Delete", message: "Category Contains Products", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


/*
 //Unused Function or Deleted Functions
 
 func noCategoryFoundAlert()
 {
     let alert = UIAlertController(title: "No items Found", message: "Press ADD Button Add Product", preferredStyle: UIAlertController.Style.alert)

     alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
     }))
     self.present(alert, animated: true, completion: nil)
 }
 
 */
