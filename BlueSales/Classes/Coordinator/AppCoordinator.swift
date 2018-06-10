//
//  AppCoordinator.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    static let shared = AppCoordinator()
    weak var navigationController: UINavigationController?
    
    fileprivate weak var window: UIWindow?
    
    var firstResponderViewController: UIViewController? {
        
        var viewCon: UIViewController?
        for window: UIWindow in UIApplication.shared.windows.reversed() {
            let windowOnMainScreen = window.screen == UIScreen.main
            if let root = window.rootViewController , windowOnMainScreen {
                viewCon = root
                break
            }
        }
        
        if let navigationController = navigationController, let last = navigationController.viewControllers.last {
            viewCon = last
        }
        
        return viewCon
    }
    
    var firstResponderNavigationController: UINavigationController? {
        if let navigationController = navigationController {
            return navigationController
        }
        return nil
    }
    
    
    func start(window: UIWindow?) {
        self.window = window
        
        if navigationController == nil {
            let navigation = UINavigationController(rootViewController: LaunchScreen())
            navigation.isNavigationBarHidden = false
            self.window?.rootViewController = navigation
            navigationController = navigation
        }
        
    }
        
}
