//
//  BugsStore.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation

public typealias CachedBugs = [LocalBug]

public protocol BugsStore {
    typealias DeletionResult = Result<Void,Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    typealias InsertionResult = Result<Void,Error>
    typealias InsertionCompletion = (InsertionResult) -> Void
    
    typealias RetrievalResult = Swift.Result<CachedBugs?,Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void
    
    func deleteCachedBugs(completion: @escaping DeletionCompletion)
    
    func insert(_ bug: LocalBug, completion: @escaping InsertionCompletion)
    
    func retrieve(limit: Int, completion: @escaping RetrievalCompletion)
}
