//
//  FKFormFieldStyle.swift
//  FormKit
//
//  Created by Jack Chamberlain on 08/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

// MARK: Line style
// Enum that defines the style of underline for a cell
// Default is Default

public enum FKFieldLineStyle {
    
    case Full
    case Default
    case Centered
    
}

// MARK: Style struct
// Defines all of the default styles to be used by the form view
// Can be overriden to provide custom styling for the form

public struct FKFormFieldStyle {
    
    public var textFieldClass: AnyClass?
    public var rowHeight: CGFloat = 30.0
    public var blankSectionHeight: CGFloat = 20.0
    public var namedSectionHeight: CGFloat = 40.0
    public var lineStyle: FKFieldLineStyle = .Default
    public var textColor: UIColor = UIColor.blackColor()
    public var placeholderColor: UIColor = UIColor.lightGrayColor()
    public var textFieldFont: UIFont = UIFont.systemFontOfSize(15.0)
    public var sectionHeaderFont: UIFont = UIFont.systemFontOfSize(18.0)
    public var textFieldInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
}