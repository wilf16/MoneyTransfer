//
//  WireframeProtocol.swift
//  MoneyTransfer
//
//  Created by Wilfred Anorma on 29/7/2018.
//  Copyright © 2018 Wilfred Anorma. All rights reserved.
//

import Foundation
import UIKit

enum WireframeError: Error {
    case invalidMainViewController
    case invalidParentViewController
}
protocol Wireframe {
    
    var mainViewController: UIViewController? { get set }
    
    //Modal Presenter
    func presentInterfaceFromViewController(_ parentViewController: UIViewController, animated:Bool, completion: (() -> Void)?) throws
    func dismissInterface(animated:Bool, completion:(() -> Void)?)
    
    func presentSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)?) throws
    func dismissSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)?)
    
    //Navigation presenter
    func pushInterfaceFromViewController(_ parentViewController: UIViewController, animated:Bool , completion: (() -> Void)?) throws
    func popInterface(animated:Bool, completion:(() -> Void)?)
    
    func pushSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)?) throws
    func popSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)?)
}

extension Wireframe {
    //Default  Funtions
    
    ////MARK: - Modal Presenter
    func presentInterfaceFromViewController(_ parentViewController:UIViewController, animated:Bool, completion: (() -> Void)? = nil) throws
    {
        guard let viewController = self.mainViewController else { throw WireframeError.invalidMainViewController }
        parentViewController.present(viewController, animated: animated, completion: completion)
    }
    func dismissInterface(animated:Bool, completion:(() -> Void)? = nil)
    {
        self.mainViewController?.dismiss(animated: animated, completion: completion)
    }
    
    func presentSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)? = nil) throws
    {
        guard let parentViewController = self.mainViewController else { throw WireframeError.invalidParentViewController }
        do  {
            try wireframe.presentInterfaceFromViewController(parentViewController, animated: animated, completion: completion)
        } catch let error {
            throw error
        }
    }
    func dismissSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)? = nil)
    {
        wireframe.dismissInterface(animated: animated, completion: completion)
    }
    
    //MARK: - Navigation presenter
    func pushInterfaceFromViewController(_ parentViewController:UIViewController, animated:Bool , completion: (() -> Void)? = nil) throws
    {
        guard let viewController = self.mainViewController else { throw WireframeError.invalidMainViewController }
        parentViewController.navigationController?.pushViewController(viewController, animated: animated)
        completion?()
    }
    func popInterface(animated:Bool, completion:(() -> Void)? = nil)
    {
        self.mainViewController?.navigationController?.popViewController(animated: animated)
        completion?()
    }
    
    func pushSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)? = nil) throws
    {
        guard let parentViewController = self.mainViewController else { throw WireframeError.invalidParentViewController }
        do  {
            try wireframe.pushInterfaceFromViewController(parentViewController, animated: animated, completion: completion)
        } catch let error {
            throw error
        }
    }
    func popSubModule(withWireframe wireframe:Wireframe, animated:Bool, completion:(() -> Void)? = nil)
    {
        wireframe.popInterface(animated: animated, completion: completion)
    }
}
