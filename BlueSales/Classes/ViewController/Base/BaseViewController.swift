//
//  BaseViewController.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import UIKit
import RxSwift

@IBDesignable class BaseViewController: UIViewController {
    
    var notificationManager = NotificationManager()
    var disposeBag: DisposeBag = DisposeBag() //RX
    
    private var navigationTitleColor = UIColor.coolBlue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
        dataBinding()
        setupBackButton()
    }
    
    func configureAppearance() {
        //override to configure view appearance
    }
    
    func dataBinding() {
        //override to configure bind data
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }
    
    
    func setupBackButton() {
        
        let count: Int? = navigationController?.viewControllers.count
        if let count = count, count > 0 && navigationItem.leftBarButtonItem == nil {
            if  !(navigationController?.viewControllers.first === self) {
                let color = navigationTitleColor
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(withImage: #imageLiteral(resourceName: "back-icn"), color: color, target: self, action: #selector(self.superBackAction(_:)))
                
                
            }
        }
    }
    
    func setNavigationBarStyle(translucent: Bool = true, backgroundColor: UIColor = .clear, titleColor: UIColor = .coolBlue) {
        navigationController?.navigationBar.isTranslucent = translucent
        navigationController?.navigationBar.setBackgroundImage(UIImage(fromColor: backgroundColor), for: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = backgroundColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationTitleColor = titleColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor]
        setupBackButton() //lets change the backbutton if is needed, in case the calor changed
    }
    
    @objc func superBackAction(_ sender: Any? = nil) {
        notificationManager.deregisterAll()
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        notificationManager.deregisterAll()
        super.dismiss(animated: flag, completion: completion)
    }
    
    deinit {
        disposeBag = DisposeBag()
        notificationManager.deregisterAll()
        NotificationCenter.default.removeObserver(self)
        print("*********Deallocating \(Mirror(reflecting: self).subjectType) ****************")
    }
    
    
}
