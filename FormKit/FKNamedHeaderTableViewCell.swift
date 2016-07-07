//
//  FKNamedHeaderTableViewCell.swift
//  FormKit
//
//  Created by Jack Chamberlain on 02/07/2016.
//  Copyright © 2016 Off Piste. All rights reserved.
//

import UIKit

class FKNamedHeaderTableViewCell: UITableViewCell {
    
    var headerLabel: UILabel!
    
    // MARK: INIT
    
    init() {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: "FKFormTableViewCell")
        self.drawLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Draw text field
    
    private func drawLabel() -> Void {
        self.headerLabel = UILabel()
        
        // Add the textfield with constraints
        
        let views = ["field": self.headerLabel]
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.headerLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[field]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[field]|", options: [], metrics: nil, views: views))
        
        self.headerLabel.text = "Header"
        self.headerLabel.textColor = UIColor.blackColor()
        self.headerLabel.font = UIFont.systemFontOfSize(15.0)
    }
    
    // MARK: Set title
    
    internal func setTitle(title: String) -> Void {
        self.headerLabel.text = title
    }

}

extension FKNamedHeaderTableViewCell: NibLoadableView, ReusableView {}
