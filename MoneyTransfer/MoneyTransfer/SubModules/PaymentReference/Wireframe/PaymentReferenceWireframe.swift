//
//  PaymentReferenceWireframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
import UIKit

class PaymentReferenceWireframe: Wireframe {
    
    var viewModel:PaymentReferenceViewModel
    var mainViewController: UIViewController?
    
    init(completionHandler: @escaping (PaymentReference?) -> Void) {
        self.viewModel = PaymentReferenceViewModel(completionHandler: completionHandler)
    }
    
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws {
        let viewController = PaymentReferenceViewController(nibName: "PaymentReferenceViewController", bundle: Bundle.main)
        viewController.viewModel = viewModel
        self.mainViewController = viewController
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
        completion?()
    }
}
