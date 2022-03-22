//
//  UIViewController+Extension.swift
//  LongAssignment
//
//  Created by Solo on 23/03/2022.
//

import UIKit

extension UIStoryboard {
    
    enum StoryboardName: String {
        case main = "Main"
    }
}


extension UIViewController {
    
    static func instantiate(from storyboardName: UIStoryboard.StoryboardName) -> Self {
        return instantiateFromStoryboardHelper(storyboardName: storyboardName)
    }
    
    private static func instantiateFromStoryboardHelper<T>(storyboardName: UIStoryboard.StoryboardName) -> T {
        let identifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
