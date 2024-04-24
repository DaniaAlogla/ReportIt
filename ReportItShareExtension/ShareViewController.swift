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
            let _ = extensionItem.attachments?.first else {
            return
        }
    }

}
