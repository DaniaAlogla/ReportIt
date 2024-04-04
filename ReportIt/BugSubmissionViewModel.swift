//
//  BugSubmissionViewModel.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import Foundation
import SwiftUI
import bug_api

public class BugSubmissionViewModel: ObservableObject {
    
    public func submitBug(_ bug: Bug) {
        convertImageToData(bug.image!) { result in
            switch result {
            case let .success(data):
                let imageData = data
                FirebaseStorageManager.shared.getImageURL(for: imageData) { result in
                    switch result {
                    case let .success(url):
                        let imageURL = url
                        RemoteBugsManager.shared.storeBug((bug.description, imageURL)) { _ in }
                        print(imageURL)
                    case .failure:
                        break
                    }
                }
            case .failure: break
            }
        }
    }
    
    private func convertImageToData(_ image: UIImage, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        completion(.success(imageData))
    }
}
