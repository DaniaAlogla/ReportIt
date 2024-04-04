//
//  BugSubmissionView.swift
//  ReportIt
//
//  Created by Dania Alogla on 25/09/1445 AH.
//

import SwiftUI

struct BugSubmissionView: View {
    
    @State private var bug = Bug(description: "", image: nil)
    
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
    }
}

#Preview {
    BugSubmissionView()
}
