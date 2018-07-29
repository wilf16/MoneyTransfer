//
//  MoneyTransferWireframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
import UIKit

class MoneyTransferReportWireframe: Wireframe {
    
    var viewModel:MoneyTransferReportViewModel
    var mainViewController: UIViewController?
    
    init(report:TransferReport, completionHandler: @escaping () -> Void) {
        self.viewModel = MoneyTransferReportViewModel(report:report, completionHandler: completionHandler)
    }
    
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) throws {
        let viewController = MoneyTransferReportViewController(nibName: "MoneyTransferReportViewController", bundle: Bundle.main)
        viewController.viewModel = viewModel
        self.mainViewController = viewController
        parentViewController.navigationController?.pushViewController(self.mainViewController!, animated: animated)
        completion?()
    }
}
