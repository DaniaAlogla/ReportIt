//
//  ShareViewController.swift
//  ReportItShareExtension
//
//  Created by Dania Alogla on 15/10/1445 AH.
//

import UIKit
import Social
import SwiftUI
import UniformTypeIdentifiers

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

class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first else {
            return
        }
        
        itemProvider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) { (providedImage, error) in
            if error != nil {
                self.closeShareExtension()
                return
            }
            
            if let image = providedImage as? UIImage {
                DispatchQueue.main.async {
                    let contentView = UIHostingController(rootView: BugSubmissionShareExtensionView(image: image))
                    self.addChild(contentView)
                    self.view.addSubview(contentView.view)
                    
                    contentView.view.translatesAutoresizingMaskIntoConstraints = false
                    contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                    contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
                    contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                    contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
                }
            } else if let url = providedImage as? URL {
                if let imageData = try? Data(contentsOf: url) {
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            let contentView = UIHostingController(rootView: BugSubmissionShareExtensionView(image: image))
                            self.addChild(contentView)
                            self.view.addSubview(contentView.view)
                            
                            contentView.view.translatesAutoresizingMaskIntoConstraints = false
                            contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                            contentView.view.bottomAnchor.constraint (equalTo: self.view.bottomAnchor).isActive = true
                            contentView.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                            contentView.view.rightAnchor.constraint (equalTo: self.view.rightAnchor).isActive = true
                        }
                    } else {
                        self.closeShareExtension()
                        return
                    }
                } else {
                    self.closeShareExtension()
                    return
                }
            } else {
                self.closeShareExtension()
                return
            }
        }
            
        NotificationCenter.default.addObserver(forName: NSNotification.Name("closeShareExtension"), object: nil, queue: nil) { _ in
            DispatchQueue.main.async {
                self.closeShareExtension()
            }
        }
    }
    
    private func closeShareExtension() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
}
