//
//  FlatPrice+CoreDataClass.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import UIKit
import CoreData

@objc(FlatPrice)
public class FlatPrice: NSManagedObject
{
    convenience init?(couponName: String, couponPrice: Int16)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        self.init(entity: FlatPrice.entity(), insertInto: context)
        self.couponName = couponName
        self.couponPrice = couponPrice
    }
}
