//
//  Products+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension Products {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    @NSManaged public var desc: String?
    @NSManaged public var mainCategory: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var quantity: Int16

}
