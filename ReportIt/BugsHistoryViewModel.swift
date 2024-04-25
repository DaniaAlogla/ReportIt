//
//  BugsHistoryViewModel.swift
//  ReportIt
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import Foundation

class BugsHistoryViewModel : ObservableObject {
    
    private let coreDataBugsStore = CoreDataBugsStore()
    
    @Published var bugs = [LocalBug]()
    
    init() {
        coreDataBugsStore.retrieve(limit: 3, completion: { result in
            switch result {
            case let .success(cachedBugs):
                if let cachedBugs {
                    self.bugs = cachedBugs
                }
            case .failure(_):
                return
            }
        })
    }
    
}
