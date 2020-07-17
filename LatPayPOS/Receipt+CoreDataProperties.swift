//
//  Receipt+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/15/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var productName: String?
    @NSManaged public var singleProductPrice: String?
    @NSManaged public var totalCount: String?
    @NSManaged public var finalPrice: String?
    @NSManaged public var date: String?
    @NSManaged public var couponName: String?
    @NSManaged public var discountedPrice: String?
    @NSManaged public var calculatedPrice: String?

}
