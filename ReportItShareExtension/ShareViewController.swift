//
//  ShareViewController.swift
//  ReportItShareExtension
//
//  Created by Dania Alogla on 15/10/1445 AH.
//

import UIKit
import Social

class ShareViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first else {
            return
        }
        
        itemProvider.loadItem(forTypeIdentifier: "public.image", options: nil) { (providedImage, error) in
            if let error = error {
                self.closeShareExtension()
                return
            }
            
            if let url = providedImage as? URL {
                if let imageData = try? Data(contentsOf: url) {
                    if let _ = UIImage(data: imageData) {
                        
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
    }
    
    private func closeShareExtension() {
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
}
