//
//  Products+CoreDataClass.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Products)
public class Products: NSManagedObject
{

    convenience init?(name: String, quantity: Int16, price: Double, mainCategory: String, desc: String)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        self.init(entity: Products.entity(), insertInto: context)
        self.name = name
        self.quantity = quantity
        self.price = price
        self.mainCategory = mainCategory
        self.desc = desc
    }
    
}
