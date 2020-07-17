//
//  ExtensionForProductsViewController.swift
//  LatPayPOS
//
//  Created by user166170 on 6/13/20.
//  Copyright © 2020 dss. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension ProductsViewController
{
    func designFunctionPVC()
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
    
    func loadCategoryValuesAtInitial()
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
            category = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            if self.category == []
            {
                self.addCategoryFirstAlert()
            }
            else
            {
                print(self.category)
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func loadProductValuesAtInitial()
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
            product = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            if self.product == []
            {
                noItemImage.isHidden = false
                productTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                productTableView.isHidden = false
                productTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func reloadProductListAgain()
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
            product = try managedContext.fetch(fetchRequest)
            print("Fetch Function Called Successfully")
            productTableView.reloadData()
            if self.product == []
            {
                noItemImage.isHidden = false
                productTableView.isHidden = true
            }
            else
            {
                noItemImage.isHidden = true
                productTableView.isHidden = false
                productTableView.reloadData()
            }
        }
        catch
        {
            print("could not fetch result")
        }
    }
    
    func addCategoryFirstAlert()
    {
        print("Hi")
        let alert1 = UIAlertController(title: "No Categories Are Found", message: "Kindly Add Categories First", preferredStyle: UIAlertController.Style.alert)

        alert1.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert1, animated: true, completion: nil)
    }
    
    func deleteProduct(at indexPath: IndexPath)
    {
        let prod = product[indexPath.row]
        
        guard let managedContext = prod.managedObjectContext else {
            return
        }
        managedContext.delete(prod)
        do
        {
            try managedContext.save()
            product.remove(at: indexPath.row)
            productTableView.deleteRows(at: [indexPath], with: .automatic)
            reloadProductListAgain()
        }
        catch
        {
            print("Could Not Delete")
            productTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
