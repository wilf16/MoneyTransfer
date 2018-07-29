//
//  ReceiverSelectionWirefframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation

import UIKit

class ReceiverSelectionWireframe: Wireframe {
    
    var viewModel:ReceiverSelectionViewModel
    var mainViewController: UIViewController?
    
    init(completionHandler: @escaping (ReceivingAccount) -> Void) {
        self.viewModel = ReceiverSelectionViewModel(completionHandler: completionHandler)
    }
    
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws {
        let viewController = ReceiverSelectionTableViewController(style: .plain)
        viewController.viewModel = viewModel
        self.mainViewController = viewController
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
        completion?()
    }
}
