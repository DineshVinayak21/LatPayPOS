//
//  LpsCfgAppConfig+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension LpsCfgAppConfig {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LpsCfgAppConfig> {
        return NSFetchRequest<LpsCfgAppConfig>(entityName: "LpsCfgAppConfig")
    }

    @NSManaged public var configDate: String?
    @NSManaged public var currency: String?
    @NSManaged public var deviceReader: String?
    @NSManaged public var lpsCfgAppConfig: String?
    @NSManaged public var merchantId: String?
    @NSManaged public var responseSecret: String?
    @NSManaged public var storeId: String?
    @NSManaged public var terminalId: String?
    @NSManaged public var terminalSecret: String?

}
