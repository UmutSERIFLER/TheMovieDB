//
//  ChooserPopoverViewModel.swift
//  TheMovieDBAPI
//
//  Created by Umut SERIFLER on 18/02/2021.
//  Copyright © 2021 UmutSERIFLER. All rights reserved.
//

import UIKit

class ChooserPopoverViewModel: NSObject , UIPopoverPresentationControllerDelegate {
    
    // `sharedInstance` because the delegate property is weak - the delegate instance needs to be retained.
    private static let sharedInstance = ChooserPopoverViewModel()
    
    private override init() {
        super.init()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(forController controller : UIViewController, referenceView: UIView? = UIView()) -> UIPopoverPresentationController {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        presentationController.delegate = ChooserPopoverViewModel.sharedInstance
        presentationController.sourceView = referenceView
        presentationController.sourceRect = referenceView?.bounds ?? CGRect(origin: .zero, size: CGSize(width: 50, height: 100))
        presentationController.permittedArrowDirections = [.up]
        return presentationController
    }
    
}
