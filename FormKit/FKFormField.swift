//
//  FKFormField.swift
//  FormKit
//
//  Created by Jack Chamberlain on 01/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

// MARK: FKFormFieldType
// Enum containing all of the possible types for field to adhere to

public enum FKFormFieldType {
    case Default
    case Email
    case Password
    case PhoneNumber
    case Number
    case ASCII
    case Address
    case Postcode
}

// MARK: FKFormField
// Controls the type of cell that is added to the form

public typealias FKFormFieldCompletion = (text: String?) -> Void

public struct FKFormField {
    
    // MARK: Public variables
    // Variables defined here can be used by anyone importing the framework
    
    public var placeholder: String?
    public var type: FKFormFieldType?
    public var initialValue: String?
    public var completion: FKFormFieldCompletion?
    public var frame: CGRect?
    
    // Sepcify the type of return key that you want to have 
    
    public var returnKeyType: UIReturnKeyType?
    
    // MARK: Framework exclusive variables
    // Variables here are not available to anyone importing the framework
    // They are only available to be used by the framework
    
    var value: String?
    
    // MARK: INIT Without initial value
    
    public init(placeholder: String?, type: FKFormFieldType?, completion: FKFormFieldCompletion) {
        self.placeholder = placeholder
        self.type = type
        self.completion = completion
    }
    
    // MARK: INIT With initial value
    
    public init(placeholder: String?, type: FKFormFieldType?, initialValue: String?, completion: FKFormFieldCompletion) {
        self.placeholder = placeholder
        self.type = type
        self.initialValue = initialValue
        self.completion = completion
    }
    
    
}
