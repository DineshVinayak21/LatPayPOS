//
//  FlatPrice+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension FlatPrice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlatPrice> {
        return NSFetchRequest<FlatPrice>(entityName: "FlatPrice")
    }

    @NSManaged public var couponName: String?
    @NSManaged public var couponPrice: Int16

}
