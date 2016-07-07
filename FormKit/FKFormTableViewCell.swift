//
//  FKFormTableViewCell.swift
//  FormKit
//
//  Created by Jack Chamberlain on 01/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

protocol FKFormTableViewCellDelegate {
    
    func fk_textFieldDidChange(withIndexPath indexPath: NSIndexPath, text: String)
    
}

class FKFormTableViewCell: UITableViewCell {
    
    // MARK: Definitions
    
    var textField: UITextField!
    
    var field: FKFormField!
    
    var delegate: FKFormTableViewCellDelegate?
    
    var indexPath: NSIndexPath!
    
    var disabled = false {
        didSet {
            self.switchState()
        }
    }

    // MARK: INIT
    
    init() {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "FKFormTableViewCell")
        self.drawTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.setAppearance()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Set appearance
    
    private func setAppearance() -> Void {
        self.selectionStyle = .None
    }
    
    // MARK: Draw text field
    
    private func drawTextField() -> Void {
        self.textField = UITextField(frame: CGRectZero)
        self.textField.delegate = self

        // Add the textfield with constraints
        
        let views = ["field": self.textField]
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.textField)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[field]-8-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[field]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: Set cell with field
    
    internal func setCell(withField field: FKFormField) -> Void {
        self.field = field
        self.textField.placeholder = field.placeholder
        self.textField.text = field.value
    }
    
    // MARK: Switch cell state
    
    internal func switchState() {
        if self.disabled {
            self.userInteractionEnabled = false
            self.textField.alpha = 0.6
        } else {
            self.userInteractionEnabled = true
            self.textField.alpha = 1.0
        }
    }

}

// MARK: UITextFieldDelegate

extension FKFormTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.field.completion?(text: textField.text)
        return
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            self.field.completion?(text: text + string)
            self.field.value = text + string
            self.delegate?.fk_textFieldDidChange(withIndexPath: self.indexPath, text: text + string)
            return true
        } else {
            self.field.completion?(text: string)
            self.field.value = string
            self.delegate?.fk_textFieldDidChange(withIndexPath: self.indexPath, text: string)
            return true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}

extension FKFormTableViewCell: NibLoadableView, ReusableView {}
