//
//  Categories+CoreDataClass.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Categories)
public class Categories: NSManagedObject
{
    convenience init?(title: String)
    {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext
        else
        {
            return nil
        }
        self.init(entity: Categories.entity(), insertInto: context)
        self.title = title
    }
}
