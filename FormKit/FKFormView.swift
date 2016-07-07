//
//  FKView.swift
//  FormKit
//
//  Created by Jack Chamberlain on 01/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

public class FKFormView: UIView {
    
    // MARK: Definitions
    
    // Form sections
    
    public var sections: Array<FKFormSection>?
    
    public var autoReturn = true
    
    // MARK: Value variable
    // Get only property that returns an array of all of the currently set field values
    // Returns an array of only the stored values
    // Can be nil
    // Loops through the form sections and form fields to retrieve all of the non nil values
    
    // TODO: Fix auto correct bug with values
    
    public var values: [String?]? {
        get {
            var array = [String?]()
            guard let sections = self.sections else { return nil }
            for section in sections {
                guard let fields = section.fields else { return nil }
                for field in fields {
                    if let value = field.value {
                        array.append(value)
                    }
                }
            }
            return array
        }
    }

    // Table view
    
    private var tableView: UITableView!
    
    // MARK: Optional init
    // Initialise a new FKFormView and return it
    
    public class func newForm() -> FKFormView {
        return FKFormView()
    }
    
    // Initialise a form with section and return it
    // If the fields and sections for the form have already been defined then they can be added
    // at the time of initialisation
    
    public class func newForm(withSections sections: Array<FKFormSection>) -> FKFormView {
        let form = FKFormView()
        form.sections = sections
        return form
    }
    
    // MARK: Awake from nib

    override public func awakeFromNib() {
        super.awakeFromNib()
        self.createTableView()
    }
    
    // MARK: Draw rect
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.createTableView()
    }
    
    // MARK: Create table view
    // Initialise the table view and add it to the view
    
    private func createTableView() -> Void {
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        self.tableView.register(FKFormTableViewCell)
        self.tableView.register(FKNamedHeaderTableViewCell)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Add the table view with constraints
        
        let views = ["table": self.tableView]
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.tableView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[table]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[table]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: Append section to form
    // Adding a new section to the form will cause the form to reload
    
    public func addSection(section: FKFormSection) {
        self.sections?.append(section)
    }
    
    // MARK: Add row to section

}

// MARK: UITableViewDataSource

extension FKFormView: UITableViewDataSource {
    
    // MARK: Number of sections in table view
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections?.count ?? 1
    }
    
    // MARK: Number of rows in section
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections?[section].fields?.count ?? 1
    }
    
    // MARK: Cell for row at index path
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = FKFormTableViewCell()
        
        guard let fkField = self.sections?[indexPath.section].fields?[indexPath.row] else {
            return cell
        }
        
        cell.setCell(withField: fkField)
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    // MARK: Table view headers
    
    // MARK: View for header in section
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionName = self.sections?[section].sectionName else { return nil }
        if sectionName == "" {
            return nil
        }
        
        let namedHeader = FKNamedHeaderTableViewCell()
        namedHeader.setTitle(sectionName)
        return namedHeader
    }
    
    // MARK: Height for header
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionName = self.sections?[section].sectionName else { return 20.0 }
        if sectionName == "" {
            return 20.0
        }
        
        return 35.0
    }
    
}

// MARK: FKFormFieldTableViewCellDelegate 

extension FKFormView: FKFormTableViewCellDelegate {
    
    func fk_textFieldDidChange(withIndexPath indexPath: NSIndexPath, text: String) {
        self.sections?[indexPath.section].fields?[indexPath.row].value = text
    }
    
}

extension FKFormView: UITableViewDelegate {}