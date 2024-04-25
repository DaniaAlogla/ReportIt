//
//  CoreDataBugsStore.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation
import CoreData

public final class CoreDataBugsStore: BugsStore {
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BugsStore")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let context: NSManagedObjectContext
    
    public init() {
        context = persistentContainer.viewContext
    }
    
    public func deleteCachedBugs(completion: @escaping DeletionCompletion) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ManagedBug")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        completion(Result {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        })
    }
    
    public func insert(_ bug: LocalBug, completion: @escaping InsertionCompletion) {
        let entity = NSEntityDescription.entity(forEntityName: "ManagedBug", in: context)
        let newBug = NSManagedObject(entity: entity!, insertInto: context)
        newBug.setValue(bug.id, forKey: "id")
        newBug.setValue("\(bug.description)", forKey: "imageDescription")
        newBug.setValue(bug.imageURL, forKey: "imageURL")
        newBug.setValue(bug.createdOn, forKey: "date")
        
        completion (Result {
            try context.save()
        })
    }
    
    public func retrieve(limit: Int, completion: @escaping RetrievalCompletion) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedBug")
        request.returnsObjectsAsFaults = false
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchLimit = limit
        
        do {
            let result = try context.fetch(request)
            let managedBugs = result as! [ManagedBug]
            completion(.success(managedBugs.map{ $0.local}))
        } catch {
            completion(.failure(error))
        }
    }
    
}

@objc(ManagedBug)
class ManagedBug: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var imageDescription: String
    @NSManaged var image: URL
    @NSManaged var date: Date
}

extension ManagedBug {
    var local: LocalBug {
        return LocalBug(id: id, imageURL: image, description: imageDescription, createdOn: date)
    }
}
