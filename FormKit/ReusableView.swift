//
//  ReusableView.swift
//  FormKit
//
//  Created by Jack Chamberlain on 01/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

protocol ReusableView: class {

    static var defaultReuseIdentifier: String { get }

}

extension ReusableView where Self: UIView {

    static var defaultReuseIdentifier: String {
        return String(Self)
    }

}

protocol NibLoadableView: class {

    static var nibName: String { get }

}

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }

}

extension UITableView {
    
    func register<T: UITableViewCell where T: ReusableView, T: NibLoadableView>(_: T.Type) {
        let bundle = NSBundle(forClass: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        
        registerNib(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCellWithIdentifier(T.defaultReuseIdentifier, forIndexPath: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }    
}