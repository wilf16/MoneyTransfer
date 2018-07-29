//
//  MoneyTransferWireframe.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import UIKit

class MoneyTransferWireframe: Wireframe {
    
    let viewModel:MoneyTransferViewModel
    var mainViewController:UIViewController?
    
    init() {
        viewModel = MoneyTransferViewModel()
        viewModel.wireframe = self
    }
    
    func presentInterfaceFromWindow(_ window:UIWindow)
    {
        let moneyTransferVC = MoneyTransferViewController(nibName: "MoneyTransferViewController", bundle: Bundle.main)
        moneyTransferVC.viewModel = viewModel
        self.mainViewController = moneyTransferVC
        
        let navigationController = UINavigationController(rootViewController: self.mainViewController!)
        window.rootViewController = navigationController
    }
    
    func showAlertView(title:String?, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.mainViewController?.present(alert, animated: true, completion: nil)
    }
    func clearData()
    {
        guard let viewController = self.mainViewController as? MoneyTransferViewController else { return }
        viewController.clearData()
    }
    
}
