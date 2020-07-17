//
//  Categories+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension Categories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }

    @NSManaged public var title: String?

}
