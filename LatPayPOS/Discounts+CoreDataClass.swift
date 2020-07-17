//
//  Discounts+CoreDataClass.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Discounts)
public class Discounts: NSManagedObject
{
    convenience init?(discountName: String, discountPercentage: Int16, discountMaximumPrice: Int16)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        self.init(entity: Discounts.entity(), insertInto: context)
        self.discountName = discountName
        self.discountPercentage = discountPercentage
        self.discountMaximumPrice = discountMaximumPrice
    }
}
