//
//  ManagedBug.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation
import CoreData

@objc(ManagedBug)
class ManagedBug: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var imageDescription: String
    @NSManaged var imageURL: URL
    @NSManaged var date: Date
}

extension ManagedBug {
    var local: LocalBug {
        return LocalBug(id: id, imageURL: imageURL, description: imageDescription, createdOn: date)
    }
}
