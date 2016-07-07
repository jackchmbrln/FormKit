//
//  ViewController.swift
//  FormKit
//
//  Created by Jack Chamberlain on 01/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Definitions
    
    @IBOutlet weak var formView: FKFormView!
    
    // MARK: View did load

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFormSections()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: Did recieve memory warning

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addFormSections() {
        let nameField = FKFormField(placeholder: "Name", type: .Default) { (text) in
            print(text)
            print(self.formView.values)
        }
        
        let passwordField = FKFormField(placeholder: "•••••••••••••", type: .Password, initialValue: nil) { (text) in
            print(text)
        }
        
        let sectionOne = FKFormSection(sectionName: "Log in", fields: [nameField, passwordField])
        
        let addressField = FKFormField(placeholder: "Address", type: FKFormFieldType.Address, initialValue: "Hello") { (text) in
            print(text)
        }
        
        var section = FKFormSection(sectionName: "Details", fields: [nameField, passwordField])
        section.addFormField(addressField)
        
        self.formView.sections = [sectionOne]
        
        self.formView.addSection(section)
        
        self.formView.addSection(FKFormSection(sectionName: "", fields: [addressField, addressField, addressField, addressField, addressField]))
    }

    @IBAction func changeFieldValue(sender: AnyObject) {
        self.formView.disableField(forIndexPath: NSIndexPath(forRow: 1, inSection: 0))
    }
}

