//
//  BugSubmissionShareExtensionView.swift
//  ReportItShareExtension
//
//  Created by Dania Alogla on 16/10/1445 AH.
//

import SwiftUI

struct BugSubmissionShareExtensionView: View {
    let image : UIImage
    var body: some View {
        NavigationStack {
            BugSubmissionView(image: image)
                .navigationTitle("Bug Submission")
                .toolbar {
                    Button("Cancel") {
                        closeShareExtension()
                    }
                }
        }
    }
    
    private func closeShareExtension() {
        NotificationCenter.default.post(name: NSNotification.Name("closeShareExtension"), object: nil)
    }
}

