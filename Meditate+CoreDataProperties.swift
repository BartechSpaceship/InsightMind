//
//  Meditate+CoreDataProperties.swift
//  InsightMind
//
//  Created by Bartek on 4/13/20.
//  Copyright © 2020 Bartek. All rights reserved.
//
//

import Foundation
import CoreData


extension Meditate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meditate> {
        return NSFetchRequest<Meditate>(entityName: "Meditate")
    }

    @NSManaged public var timeSaved: Int64

}
