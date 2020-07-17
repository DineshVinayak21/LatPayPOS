//
//  Discounts+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension Discounts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Discounts> {
        return NSFetchRequest<Discounts>(entityName: "Discounts")
    }

    @NSManaged public var discountName: String?
    @NSManaged public var discountPercentage: Int16
    @NSManaged public var discountMaximumPrice: Int16

}
