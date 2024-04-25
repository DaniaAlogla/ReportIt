//
//  LocalBug.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation

public struct LocalBug : Hashable {
    public let id: UUID
    public let imageURL: URL
    public let description: String
    public let createdOn: Date
}
