//
//  FKFormSection.swift
//  FormKit
//
//  Created by Jack Chamberlain on 03/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import Foundation

// MARK: FKFormSection struct
// Defines a section in the form that contains an optional section name
// + the fields / rows contained within that section

public struct FKFormSection {
    
    var sectionName: String?
    var fields: Array<FKFormField>?
    
    // MARK: Add row to section
    
    public mutating func addFormField(field: FKFormField) -> Void {
        self.fields?.append(field)
    }
    
}