//
//  UIViewController + Storyboard.swift
//  iMusic
//
//  Created by RAFAEL on 02.06.2023.
//  Copyright (c) 2023 RAFAEL. All rights reserved.

import UIKit


extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard!")
        }
    }
}
