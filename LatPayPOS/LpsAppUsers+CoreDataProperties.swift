//
//  LpsAppUsers+CoreDataProperties.swift
//  LatPayPOS
//
//  Created by user166170 on 6/14/20.
//  Copyright © 2020 dss. All rights reserved.
//
//

import Foundation
import CoreData


extension LpsAppUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LpsAppUsers> {
        return NSFetchRequest<LpsAppUsers>(entityName: "LpsAppUsers")
    }

    @NSManaged public var appUsersEmail: String?
    @NSManaged public var appUsersMobile: String?
    @NSManaged public var appUsersPassword: String?
    @NSManaged public var appUsersRole: String?
    @NSManaged public var appUsersStatus: String?
    @NSManaged public var appUsersUserName: String?
    @NSManaged public var lpsAppUsersID: String?

}
