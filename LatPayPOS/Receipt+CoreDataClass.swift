//
//  Receipt+CoreDataClass.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Receipt)
public class Receipt: NSManagedObject
{
    convenience init?(productName: String, singleProductPrice: String, totalCount: String, finalPrice: String, date: String, couponName: String, discountedPrice: String, calculatedPrice: String)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        self.init(entity: Receipt.entity(), insertInto: context)
        self.productName = productName
        self.singleProductPrice = singleProductPrice
        self.totalCount = totalCount
        self.finalPrice = finalPrice
        self.date = date
        self.couponName = couponName
        self.discountedPrice = discountedPrice
        self.calculatedPrice = calculatedPrice
    }
}
