//
//  NotificationManager.swift
//  BlueSales
//
//  Created by Santiago Bustamante on 6/10/18.
//  Copyright © 2018 Santiago Bustamante. All rights reserved.
//

import Foundation
import UIKit

class NotificationManager {
    
    fileprivate var observerTokens: [Any] = []
    
    deinit {
        deregisterAll()
    }
    
    func deregisterAll() {
        for token in observerTokens {
            NotificationCenter.default.removeObserver(token)
        }
        
        observerTokens = []
    }
    
    func addObserver(forName name: NSNotification.Name, action: @escaping ((Notification) -> ())) {
        let newToken = NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) {note in
            action(note)
        }
        
        observerTokens.append(newToken)
    }
    
    func addObserver(forNameString name: String, forObject object: Any? = nil, action: @escaping ((Notification) -> ())) {
        let newToken = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: name), object: object, queue: nil) {note in
            action(note)
        }
        
        observerTokens.append(newToken)
    }
}

extension Notification {
    
    
    var keyboardHeight: CGFloat {
        if let keyboardSize = (self.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            return keyboardSize.height
        }
        return 0
    }
    
    var keyboardAnimationDuration: Double {
        if let animationDuration = self.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double {
            return animationDuration
        }
        return 0
    }
    
    var keyboardAnimationOptions: UIViewAnimationOptions {
        if let options = self.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int {
            return UIViewAnimationOptions(rawValue: UInt(options << 16))
        }
        return UIViewAnimationOptions.curveEaseIn
    }
    
    var keyboardAnimationType: UIViewAnimationOptions {
        return keyboardAnimationOptions
    }
}

extension NotificationManager {
    
    func postNotification(withName aName: Notification.Name, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: aName, object: object, userInfo: userInfo)
    }
    
    func postNotification(withNameString aName: String, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: aName), object: object, userInfo: userInfo)
    }
    
}
