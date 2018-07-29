//
//  SenderSelectionWireframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class SenderSelectionWireframe: Wireframe {
    
    var viewModel:SenderSelectionViewModel
    var mainViewController: UIViewController?
    
    init(completionHandler: @escaping (SendingAccount) -> Void) {
        self.viewModel = SenderSelectionViewModel(completionHandler: completionHandler)
    }
    
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws {
        let viewController = SenderSelectionViewController(style: .plain)
        viewController.viewModel = viewModel
        self.mainViewController = viewController
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
        completion?()
    }
}
