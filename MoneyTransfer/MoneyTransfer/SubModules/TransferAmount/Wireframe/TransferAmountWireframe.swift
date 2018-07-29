//
//  TransferAmountWireframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
import UIKit

class TransferAmountWireframe: Wireframe {
    
    var viewModel:TransferAmountViewModel
    var mainViewController: UIViewController?
    
    init(completionHandler: @escaping (TransferAmount) -> Void) {
        self.viewModel = TransferAmountViewModel(completionHandler: completionHandler)
    }
    
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws {
        let viewController = TransferAmountViewController(nibName: "TransferAmountViewController", bundle: Bundle.main)
        viewController.viewModel = viewModel
        self.mainViewController = viewController
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
        completion?()
    }
}
