//
//  BugSubmissionView.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

public class BugSubmissionViewModel: ObservableObject {
    private func convertImageToData(_ image: UIImage, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        completion(.success(imageData))
    }
}

struct BugSubmissionView: View {
    
    @ObservedObject var bugSubmissionViewModel = BugSubmissionViewModel()
    @State private var bug = Bug(description: "", image: nil)
    @State private var showImagePicker = false

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Bug Details")) {
                    TextField("Description", text: $bug.description)
                    if let image = bug.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 200)
                    }
                    Button(action: {
                        showImagePicker.toggle()
                    }) {
                        Text("Add Image")
                    }
                }
            }
            Button {
                
            } label: {
                Text("Submit")
            }
        }.navigationTitle("Bug Submission")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $bug.image)
        }
    }
}

#Preview {
    BugSubmissionView()
}
